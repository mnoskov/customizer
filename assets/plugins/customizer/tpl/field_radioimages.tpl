<div class="field-group images-group">
    <div class="field-title">
        <?= $field['title'] ?>
    </div>

    <?php foreach ($field['images'] as $key => $image): ?>
        <label>
            <input type="radio" name="<?= $field['name'] ?>" value="<?= $key ?>"<?= $key == $value ? ' checked' : '' ?>>
            <span><img src="<?= $image ?>"></span>
        </label>
    <?php endforeach; ?>
</div>