<div class="field-group toggle-group">
    <div class="field-title">
        <input type="hidden" name="<?= $field['name'] ?>" value="0">
        
        <label>
            <input type="checkbox" name="<?= $field['name'] ?>" value="1" <?= $value == 1 ? ' checked' : '' ?>>
            <span><?= $field['title'] ?></span>
        </label>
    </div>
</div>