 python3 -m torch.distributed.run --nnodes 1 --nproc_per_node 4 ./llava/train/train_xformers.py \
  --deepspeed $ds_config \
  --lora_enable True --lora_r 128 --lora_alpha 256 --mm_projector_lr 2e-5 \
  --model_name_or_path $model_name_or_path \
  --version mistral_instruct \
  --data_path $path_to_instruct_data \
  --image_folder $path_to_images \
  --vision_tower openai/clip-vit-large-patch14-336 \
  --pretrain_mm_mlp_adapter $path_to_pretrain_mm_projector \
    --mm_projector_type mlp2x_gelu \
    --mm_vision_select_layer -2 \
    --mm_use_im_start_end False \
    --mm_use_im_patch_token False \
    --image_aspect_ratio pad \
    --group_by_modality_length True \
    --bf16 True \
    --output_dir $output_dir \
    --num_train_epochs 1 \
    --per_device_train_batch_size 8 \
    --per_device_eval_batch_size 4 \
    --gradient_accumulation_steps 1 \
    --evaluation_strategy "no" \
    --save_strategy "epoch" \
    --save_total_limit 1 \
    --learning_rate 2e-5 \
    --weight_decay 0. \
    --warmup_ratio 0.03 \
    --lr_scheduler_type "cosine" \
    --logging_steps 3 \
    --model_max_length 2048 \
    --gradient_checkpointing True \
    --dataloader_num_workers 2 \
    --lazy_preprocess True \
    --report_to "tensorboard"'
