Return-Path: <linux-acpi+bounces-17518-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C88BB5844
	for <lists+linux-acpi@lfdr.de>; Thu, 02 Oct 2025 23:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4811D4E53E2
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Oct 2025 21:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B1C26FA67;
	Thu,  2 Oct 2025 21:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="gP0Y0K4x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF14C1EDA0B
	for <linux-acpi@vger.kernel.org>; Thu,  2 Oct 2025 21:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759442297; cv=none; b=P6didBqoYhv+iZ3NL4hbA9YDILafgFZ6ijnPSmowdsERDVengqKO8HqXQMinr0ItfIw3vdBCHE6CmQLyuYOZSPEf7BneAHktyX08Q1PYItlz/4DvlN+cci2PivPUn3wZjZi461M+pHjNbznWNWvjgxHBox3baZvCmjWOv9OnsiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759442297; c=relaxed/simple;
	bh=iRbv56XOHuj5ELLYlYMS6qWgcR4X5GjCSiHFhQd/DR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GO4funl4TrI1bEhCiu2UStsXaaErcv3/ilJ0Y/pWnuOiu88/uCbR7VoV4XahfQWI4j/JZXZRHZ7uBoRyTcqtQdOBaKWWmNu2iEKM3gQiP8RhBNnaPkMDSvp0Nt5EGh45M1ckF6GQz4dXnjEQsTKPeJiFAUiZqO2neaTiFfSEIKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=gP0Y0K4x; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id C7715240104
	for <linux-acpi@vger.kernel.org>; Thu,  2 Oct 2025 23:58:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1759442285; bh=+jy0sLZI4pDAMVQyKmSWdbBXDUNmQ1tBUCM7y3g5Dgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Autocrypt:OpenPGP:From;
	b=gP0Y0K4xznWGkLAMY4ryR7k120oqfOOZYLzBfH3TOm5QrSMHoDOJgIn+JY/xiBgKJ
	 iu2fVObG9N3uxSqKl0r+CLSZluhYOSHm/GkKknRmYxViwdqylYhpdWi0FItC10cdBD
	 y+a7iX43KlDGanQ48iv7fsnlxWVJ5Dmok782nxemDLbIhZopiDaHALN9+dzz4kAaEt
	 sF+TQURFn3aqRR9FGUWcf+6ULQpvIJO22CE8bMlElfKzQHTXb+6EHrtx6YMT5PCGz8
	 K8fgNMGCZlaUTB7EDHt1g75dVFLtO4nH/xbtXZqdr48skJGy3iJIZN9DWPmVVRSITx
	 UN8jTGYrFLr4Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cd5JX1by1z9rxF;
	Thu,  2 Oct 2025 23:58:04 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Probst <markus.probst@posteo.de>
Subject: [PATCH] gpio: of: make it possible to reference gpios probed in acpi in device tree
Date: Thu, 02 Oct 2025 21:58:05 +0000
Message-ID: <20251002215759.1836706-1-markus.probst@posteo.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=xsFNBGiDvXgBEADAXUceKafpl46S35UmDh2wRvvx+UfZbcTjeQOlSwKP7YVJ4JOZrVs93qReNLkO
  WguIqPBxR9blQ4nyYrqSCV+MMw/3ifyXIm6Pw2YRUDg+WTEOjTixRCoWDgUj1nOsvJ9tVAm76Ww+
  /pAnepVRafMID0rqEfD9oGv1YrfpeFJhyE2zUw3SyyNLIKWD6QeLRhKQRbSnsXhGLFBXCqt9k5JA
  RhgQof9zvztcCVlT5KVvuyfC4H+HzeGmu9201BVyihJwKdcKPq+n/aY5FUVxNTgtI9f8wIbmfAja
  oT1pjXSp+dszakA98fhONM98pOq723o/1ZGMZukyXFfsDGtA3BB79HoopHKujLGWAGskzClwTjRQ
  xBqxh/U/lL1pc+0xPWikTNCmtziCOvv0KA0arDOMQlyFvImzX6oGVgE4ksKQYbMZ3Ikw6L1Rv1J+
  FvN0aNwOKgL2ztBRYscUGcQvA0Zo1fGCAn/BLEJvQYShWKeKqjyncVGoXFsz2AcuFKe1pwETSsN6
  OZncjy32e4ktgs07cWBfx0v62b8md36jau+B6RVnnodaA8++oXl3FRwiEW8XfXWIjy4umIv93tb8
  8ekYsfOfWkTSewZYXGoqe4RtK80ulMHb/dh2FZQIFyRdN4HOmB4FYO5sEYFr9YjHLmDkrUgNodJC
  XCeMe4BO4iaxUQARAQABzRdtYXJrdXMucHJvYnN0QHBvc3Rlby5kZcLBkQQTAQgAOxYhBIJ0GMT0
  rFjncjDEczR2H/jnrUPSBQJog714AhsDBQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEDR2
  H/jnrUPSgdkQAISaTk2D345ehXEkn5z2yUEjaVjHIE7ziqRaOgn/QanCgeTUinIv6L6QXUFvvIfH
  1OLPwQ1hfvEg9NnNLyFezWSy6jvoVBTIPqicD/r3FkithnQ1IDkdSjrarPMxJkvuh3l7XZHo49GV
  HQ8i5zh5w4YISrcEtE99lJisvni2Jqx7we5tey9voQFDyM8jxlSWv3pmoUTCtBkX/eKHJXosgsuS
  B4TGDCVPOjla/emI5c9MhMG7O4WEEmoSdPbmraPw66YZD6uLyhV4DPHbiDWRzXWnClHSyjB9rky9
  lausFxogvu4l9H+KDsXIadNDWdLdu1/enS/wDd9zh5S78rY2jeXaG4mnf4seEKamZ7KQ6FIHrcyP
  ezdDzssPQcTQcGRMQzCn6wP3tlGk7rsfmyHMlFqdRoNNv+ZER/OkmZFPW655zRfbMi0vtrqK2Awm
  9ggobb1oktfd9PPNXMUY+DNVlgR2G7jLnenSoQausLUm0pHoNE8TWFv851Y6SOYnvn488sP1Tki5
  F3rKwclawQFHUXTCQw+QSh9ay8xgnNZfH+u9NY7w3gPoeKBOAFcBc2BtzcgekeWS8qgEmm2/oNFV
  G0ivPQbRx8FjRKbuF7g3YhgNZZ0ac8FneuUtJ2PkSIFTZhaAiC0utvxk0ndmWFiW4acEkMZGrLaM
  L2zWNjrqwsD2zsFNBGiDvXgBEADCXQy1n7wjRxG12DOVADawjghKcG+5LtEf31WftHKLFbp/HArj
  BhkT6mj+CCI1ClqY+FYU5CK/s0ScMfLxRGLZ0Ktzawb78vOgBVFT3yB1yWBTewsAXdqNqRooaUNo
  8cG/NNJLjhccH/7PO/FWX5qftOVUJ/AIsAhKQJ18Tc8Ik73v427EDxuKb9mTAnYQFA3Ev3hAiVbO
  6Rv39amVOfJ8sqwiSUGidj2Fctg2aB5JbeMln0KCUbTD1LhEFepeKypfofAXQbGwaCjAhmkWy/q3
  IT1mUrPxOngbxdRoOx1tGUC0HCMUW1sFaJgQPMmDcR0JGPOpgsKnitsSnN7ShcCr1buel7vLnUMD
  +TAZ5opdoF6HjAvAnBQaijtK6minkrM0seNXnCg0KkV8xhMNa6zCs1rq4GgjNLJue2EmuyHooHA4
  7JMoLVHcxVeuNTp6K2+XRx0Pk4e2Lj8IVy9yEYyrywEOC5XRW37KJjsiOAsumi1rkvM7QREWgUDe
  Xs0+RpxI3QrrANh71fLMRo7LKRF3Gvw13NVCCC9ea20P4PwhgWKStkwO2NO+YJsAoS1QycMi/vKu
  0EHhknYXamaSV50oZzHKmX56vEeJHTcngrM8R1SwJCYopCx9gkz90bTVYlitJa5hloWTYeMD7FNj
  Y6jfVSzgM/K4gMgUNDW/PPGeMwARAQABwsF2BBgBCAAgFiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IF
  AmiDvXgCGwwACgkQNHYf+OetQ9LHDBAAhk+ab8+WrbS/b1/gYW3q1KDiXU719nCtfkUVXKidW5Ec
  Idlr5HGt8ilLoxSWT2Zi368iHCXS0WenGgPwlv8ifvB7TOZiiTDZROZkXjEBmU4nYjJ7GymawpWv
  oQwjMsPuq6ysbzWtOZ7eILx7cI0FjQeJ/Q2baRJub0uAZNwBOxCkAS6lpk5Fntd2u8CWmDQo4SYp
  xeuQ+pwkp0yEP30RhN2BO2DXiBEGSZSYh+ioGbCHQPIV3iVj0h6lcCPOqopZqyeCfigeacBI0nvN
  jHWz/spzF3+4OS+3RJvoHtAQmProxyGib8iVsTxgZO3UUi4TSODeEt0i0kHSPY4sCciOyXfAyYoD
  DFqhRjOEwBBxhr+scU4C1T2AflozvDwq3VSONjrKJUkhd8+WsdXxMdPFgBQuiKKwUy11mz6KQfcR
  wmDehF3UaUoxa+YIhWPbKmycxuX/D8SvnqavzAeAL1OcRbEI/HsoroVlEFbBRNBZLJUlnTPs8ZcU
  4+8rq5YX1GUrJL3jf6SAfSgO7UdkEET3PdcKFYtS+ruV1Cp5V0q4kCfI5jk25iiz8grM2wOzVSsc
  l1mEkhiEPH87HP0whhb544iioSnumd3HJKL7dzhRegsMizatupp8D65A2JziW0WKopa1iw9fti3A
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

sometimes it is necessary to use both acpi and device tree to declare
devices. Not every gpio device driver which has an acpi_match_table has
an of_match table (e.g. amd-pinctrl). Furthermore gpio is an device which
can't be easily disabled in acpi and then redeclared in device tree, as
it often gets used by other devices declared in acpi (e.g. via GpioInt or
GpioIo). Thus a disable of acpi and migration to device tree is not always
possible or very time consuming, while acpi by itself is very limited and
not always sufficient. This won't affect most configurations, as most of
the time either CONFIG_ACPI or CONFIG_OF gets enabled, not both.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 drivers/gpio/gpiolib-of.c | 241 +++++++++++++++++++++++---------------
 1 file changed, 145 insertions(+), 96 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 37ab78243fab..c472b86148b3 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -18,6 +18,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/acpi.h>
 
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
@@ -118,6 +119,107 @@ int of_gpio_count(const struct fwnode_handle *fwnode, const char *con_id)
 	return ret ? ret : -ENOENT;
 }
 
+/**
+ * of_gpio_twocell_xlate - translate twocell gpiospec to the GPIO number and flags
+ * @gc:		pointer to the gpio_chip structure
+ * @gpiospec:	GPIO specifier as found in the device tree
+ * @flags:	a flags pointer to fill in
+ *
+ * This is simple translation function, suitable for the most 1:1 mapped
+ * GPIO chips. This function performs only one sanity check: whether GPIO
+ * is less than ngpios (that is specified in the gpio_chip).
+ *
+ * Returns:
+ * GPIO number (>= 0) on success, negative errno on failure.
+ */
+static int of_gpio_twocell_xlate(struct gpio_chip *gc,
+				 const struct of_phandle_args *gpiospec,
+				 u32 *flags)
+{
+	/*
+	 * We're discouraging gpio_cells < 2, since that way you'll have to
+	 * write your own xlate function (that will have to retrieve the GPIO
+	 * number and the flags from a single gpio cell -- this is possible,
+	 * but not recommended).
+	 */
+	if (gc->of_gpio_n_cells != 2) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	if (WARN_ON(gpiospec->args_count < gc->of_gpio_n_cells))
+		return -EINVAL;
+
+	if (gpiospec->args[0] >= gc->ngpio)
+		return -EINVAL;
+
+	if (flags)
+		*flags = gpiospec->args[1];
+
+	return gpiospec->args[0];
+}
+
+/**
+ * of_gpio_threecell_xlate - translate threecell gpiospec to the GPIO number and flags
+ * @gc:		pointer to the gpio_chip structure
+ * @gpiospec:	GPIO specifier as found in the device tree
+ * @flags:	a flags pointer to fill in
+ *
+ * This is simple translation function, suitable for the most 1:n mapped
+ * GPIO chips, i.e. several GPIO chip instances from one device tree node.
+ * In this case the following binding is implied:
+ *
+ * foo-gpios = <&gpio instance offset flags>;
+ *
+ * Returns:
+ * GPIO number (>= 0) on success, negative errno on failure.
+ */
+static int of_gpio_threecell_xlate(struct gpio_chip *gc,
+				   const struct of_phandle_args *gpiospec,
+				   u32 *flags)
+{
+	if (gc->of_gpio_n_cells != 3) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	if (WARN_ON(gpiospec->args_count != 3))
+		return -EINVAL;
+
+	/*
+	 * Check chip instance number, the driver responds with true if
+	 * this is the chip we are looking for.
+	 */
+	if (!gc->of_node_instance_match(gc, gpiospec->args[0]))
+		return -EINVAL;
+
+	if (gpiospec->args[1] >= gc->ngpio)
+		return -EINVAL;
+
+	if (flags)
+		*flags = gpiospec->args[2];
+
+	return gpiospec->args[1];
+}
+
+static int of_gpiochip_init(struct gpio_chip *chip)
+{
+	if (!chip->of_xlate) {
+		if (chip->of_gpio_n_cells == 3) {
+			if (!chip->of_node_instance_match)
+				return -EINVAL;
+			chip->of_xlate = of_gpio_threecell_xlate;
+		} else {
+			chip->of_gpio_n_cells = 2;
+			chip->of_xlate = of_gpio_twocell_xlate;
+		}
+	}
+
+	if (chip->of_gpio_n_cells > MAX_PHANDLE_ARGS)
+		return -EINVAL;
+	return 0;
+}
+
 static int of_gpiochip_match_node_and_xlate(struct gpio_chip *chip,
 					    const void *data)
 {
@@ -134,6 +236,40 @@ of_find_gpio_device_by_xlate(const struct of_phandle_args *gpiospec)
 	return gpio_device_find(gpiospec, of_gpiochip_match_node_and_xlate);
 }
 
+#ifdef CONFIG_ACPI
+static int of_gpiochip_match_acpi_path(struct gpio_chip *chip,
+				       const void *data)
+{
+	const char *acpi_path = data;
+	const char *chip_acpi_path;
+	acpi_handle handle;
+	int ret;
+
+	handle = ACPI_HANDLE(chip->parent);
+	if (!handle)
+		return 0;
+	chip_acpi_path = acpi_handle_path(handle);
+	if (!chip_acpi_path)
+		return 0;
+
+	ret = !strcmp(acpi_path, chip_acpi_path);
+
+	if (ret)
+		ret = !of_gpiochip_init(chip);
+
+	return ret;
+}
+
+static struct gpio_device *of_find_gpio_device_by_acpi(const struct of_phandle_args *gpiospec)
+{
+	const char *acpi_path = NULL;
+
+	if (of_property_read_string(gpiospec->np, "acpi-path", &acpi_path))
+		return NULL;
+	return gpio_device_find(acpi_path, of_gpiochip_match_acpi_path);
+}
+#endif
+
 static struct gpio_desc *of_xlate_and_get_gpiod_flags(struct gpio_chip *chip,
 					struct of_phandle_args *gpiospec,
 					enum of_gpio_flags *flags)
@@ -423,6 +559,12 @@ static struct gpio_desc *of_get_named_gpiod_flags(const struct device_node *np,
 
 	struct gpio_device *gdev __free(gpio_device_put) =
 				of_find_gpio_device_by_xlate(&gpiospec);
+	#ifdef CONFIG_ACPI
+	if (!gdev) {
+		gdev = of_find_gpio_device_by_acpi(&gpiospec);
+	}
+	#endif
+
 	if (!gdev) {
 		desc = ERR_PTR(-EPROBE_DEFER);
 		goto out;
@@ -948,89 +1090,6 @@ struct notifier_block gpio_of_notifier = {
 };
 #endif /* CONFIG_OF_DYNAMIC */
 
-/**
- * of_gpio_twocell_xlate - translate twocell gpiospec to the GPIO number and flags
- * @gc:		pointer to the gpio_chip structure
- * @gpiospec:	GPIO specifier as found in the device tree
- * @flags:	a flags pointer to fill in
- *
- * This is simple translation function, suitable for the most 1:1 mapped
- * GPIO chips. This function performs only one sanity check: whether GPIO
- * is less than ngpios (that is specified in the gpio_chip).
- *
- * Returns:
- * GPIO number (>= 0) on success, negative errno on failure.
- */
-static int of_gpio_twocell_xlate(struct gpio_chip *gc,
-				 const struct of_phandle_args *gpiospec,
-				 u32 *flags)
-{
-	/*
-	 * We're discouraging gpio_cells < 2, since that way you'll have to
-	 * write your own xlate function (that will have to retrieve the GPIO
-	 * number and the flags from a single gpio cell -- this is possible,
-	 * but not recommended).
-	 */
-	if (gc->of_gpio_n_cells != 2) {
-		WARN_ON(1);
-		return -EINVAL;
-	}
-
-	if (WARN_ON(gpiospec->args_count < gc->of_gpio_n_cells))
-		return -EINVAL;
-
-	if (gpiospec->args[0] >= gc->ngpio)
-		return -EINVAL;
-
-	if (flags)
-		*flags = gpiospec->args[1];
-
-	return gpiospec->args[0];
-}
-
-/**
- * of_gpio_threecell_xlate - translate threecell gpiospec to the GPIO number and flags
- * @gc:		pointer to the gpio_chip structure
- * @gpiospec:	GPIO specifier as found in the device tree
- * @flags:	a flags pointer to fill in
- *
- * This is simple translation function, suitable for the most 1:n mapped
- * GPIO chips, i.e. several GPIO chip instances from one device tree node.
- * In this case the following binding is implied:
- *
- * foo-gpios = <&gpio instance offset flags>;
- *
- * Returns:
- * GPIO number (>= 0) on success, negative errno on failure.
- */
-static int of_gpio_threecell_xlate(struct gpio_chip *gc,
-				   const struct of_phandle_args *gpiospec,
-				   u32 *flags)
-{
-	if (gc->of_gpio_n_cells != 3) {
-		WARN_ON(1);
-		return -EINVAL;
-	}
-
-	if (WARN_ON(gpiospec->args_count != 3))
-		return -EINVAL;
-
-	/*
-	 * Check chip instance number, the driver responds with true if
-	 * this is the chip we are looking for.
-	 */
-	if (!gc->of_node_instance_match(gc, gpiospec->args[0]))
-		return -EINVAL;
-
-	if (gpiospec->args[1] >= gc->ngpio)
-		return -EINVAL;
-
-	if (flags)
-		*flags = gpiospec->args[2];
-
-	return gpiospec->args[1];
-}
-
 #if IS_ENABLED(CONFIG_OF_GPIO_MM_GPIOCHIP)
 #include <linux/gpio/legacy-of-mm-gpiochip.h>
 /**
@@ -1256,19 +1315,9 @@ int of_gpiochip_add(struct gpio_chip *chip)
 	if (!np)
 		return 0;
 
-	if (!chip->of_xlate) {
-		if (chip->of_gpio_n_cells == 3) {
-			if (!chip->of_node_instance_match)
-				return -EINVAL;
-			chip->of_xlate = of_gpio_threecell_xlate;
-		} else {
-			chip->of_gpio_n_cells = 2;
-			chip->of_xlate = of_gpio_twocell_xlate;
-		}
-	}
-
-	if (chip->of_gpio_n_cells > MAX_PHANDLE_ARGS)
-		return -EINVAL;
+	ret = of_gpiochip_init(chip);
+	if (ret)
+		return ret;
 
 	ret = of_gpiochip_add_pin_range(chip);
 	if (ret)
-- 
2.49.1


