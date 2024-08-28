Return-Path: <linux-acpi+bounces-7931-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BC9962DDA
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 18:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53B1286566
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 16:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E665D1A3BD1;
	Wed, 28 Aug 2024 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YqFj2LHB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7267168486;
	Wed, 28 Aug 2024 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724863498; cv=none; b=FM7omPBkl6cEGjm69KJVZISjJDSv3JGiEnbvzRFPK/OZ6hFLNmup/JGhVjR3TRKtUWf45AD/8MaAWPBh39X4V3EVSeCVy+5zPz4dbL4MqadoDLCXxfRujiEmay9fj45449uSfgicTPmMDn65bQg1E+xx+cpOanraWRfroKRUoyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724863498; c=relaxed/simple;
	bh=UoEYFYnEXJQS01t3v63zrCRfvw5KU0fUZxHvp8vEgbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KpzjoW3QVPPMmBF0QKbLgW3K49lO5nOj6Te4+qg+DqBTGj1SPTJ73DuTXcTIfSpTwPb/MKuNr8fG90qutE+nZqeIhWRe34YaPkHzKPC0EkomnSULjeOOErq2sqDgVp1PbKi/LA30TZoJ3O1/jz5OSprmO+hWWQGabWQlU9LU7Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YqFj2LHB; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724863496; x=1756399496;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UoEYFYnEXJQS01t3v63zrCRfvw5KU0fUZxHvp8vEgbM=;
  b=YqFj2LHBw8nz7kU5sGc9qPsTsP5FUxeMJjz3LTdx92DTcXUlhx/uXj2h
   FlaQljubroxgwFrnc4qVTxHgyLbr045NIwfBJYIXEd5e3s1uP7gft6VYx
   4Xs1wfISM7VbE0YMocszG2vWCxke6jg7SUe3GY90ofx8fhbliS0HcnsZH
   ULwHMC38ka4247cz9mBpNY2Nz4xrb153oQctc6kL8s9c+XJTB/uj0DIeh
   R5U86q1M95jaknSxYCRLuKYo1FSgMLe/YjFba6qSgQxZqfc7tQGBCNQQp
   9+RFj9xnkM606ylLAu5ta32KPOa3g7BlKQ23//Z18job8mS5seAHuyQS4
   w==;
X-CSE-ConnectionGUID: bUoBndyaRyWmrZ9qqMVtTA==
X-CSE-MsgGUID: JOwkR7TDS1yi64XcoBdH2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23214936"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="23214936"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 09:44:55 -0700
X-CSE-ConnectionGUID: /hnWucaETeiDHKWB9D2z/Q==
X-CSE-MsgGUID: oHDoLH+1RsSmGUTiNNaF8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="63275529"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 28 Aug 2024 09:44:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4C926142; Wed, 28 Aug 2024 19:44:51 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 1/1] gpiolib: Update the kernel documentation - add Return sections
Date: Wed, 28 Aug 2024 19:41:35 +0300
Message-ID: <20240828164449.2777666-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

$ scripts/kernel-doc -v -none -Wall drivers/gpio/gpiolib* 2>&1 | grep -w warning | wc -l
67

Fix these by adding Return sections. While at it, make sure all of
Return sections use the same style.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: consistently used %FOO for constants, "active-low" and "errno" (Bart)
 drivers/gpio/gpiolib-acpi.c   |  22 +++--
 drivers/gpio/gpiolib-cdev.c   |   8 +-
 drivers/gpio/gpiolib-devres.c |  38 +++++++-
 drivers/gpio/gpiolib-legacy.c |   3 +
 drivers/gpio/gpiolib-of.c     |  48 ++++++++---
 drivers/gpio/gpiolib-swnode.c |   2 +-
 drivers/gpio/gpiolib-sysfs.c  |   6 +-
 drivers/gpio/gpiolib.c        | 157 +++++++++++++++++++++++++++-------
 8 files changed, 226 insertions(+), 58 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index cf4b1f068bac..78ecd56123a3 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -153,8 +153,12 @@ static int acpi_gpiochip_find(struct gpio_chip *gc, const void *data)
  * @path:	ACPI GPIO controller full path name, (e.g. "\\_SB.GPO1")
  * @pin:	ACPI GPIO pin number (0-based, controller-relative)
  *
- * Return: GPIO descriptor to use with Linux generic GPIO API, or ERR_PTR
- * error value. Specifically returns %-EPROBE_DEFER if the referenced GPIO
+ * Returns:
+ * GPIO descriptor to use with Linux generic GPIO API.
+ * If the GPIO cannot be translated or there is an error an ERR_PTR is
+ * returned.
+ *
+ * Specifically returns %-EPROBE_DEFER if the referenced GPIO
  * controller does not have GPIO chip registered at the moment. This is to
  * support probe deferral.
  */
@@ -224,6 +228,9 @@ EXPORT_SYMBOL_GPL(acpi_gpio_get_irq_resource);
  *			       I/O resource or return False if not.
  * @ares:	Pointer to the ACPI resource to fetch
  * @agpio:	Pointer to a &struct acpi_resource_gpio to store the output pointer
+ *
+ * Returns:
+ * %true if GpioIo resource is found, %false otherwise.
  */
 bool acpi_gpio_get_io_resource(struct acpi_resource *ares,
 			       struct acpi_resource_gpio **agpio)
@@ -876,7 +883,9 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode,
  * that case @index is used to select the GPIO entry in the property value
  * (in case of multiple).
  *
- * If the GPIO cannot be translated or there is an error, an ERR_PTR is
+ * Returns:
+ * GPIO descriptor to use with Linux generic GPIO API.
+ * If the GPIO cannot be translated or there is an error an ERR_PTR is
  * returned.
  *
  * Note: if the GPIO resource has multiple entries in the pin list, this
@@ -924,6 +933,8 @@ static struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
  * resource with the relevant information from a data-only ACPI firmware node
  * and uses that to obtain the GPIO descriptor to return.
  *
+ * Returns:
+ * GPIO descriptor to use with Linux generic GPIO API.
  * If the GPIO cannot be translated or there is an error an ERR_PTR is
  * returned.
  */
@@ -1042,7 +1053,8 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
  * The GPIO is considered wake capable if the GpioInt resource specifies
  * SharedAndWake or ExclusiveAndWake.
  *
- * Return: Linux IRQ number (> %0) on success, negative errno on failure.
+ * Returns:
+ * Linux IRQ number (> 0) on success, negative errno on failure.
  */
 int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *con_id, int index,
 				  bool *wake_capable)
@@ -1429,7 +1441,7 @@ static int acpi_find_gpio_count(struct acpi_resource *ares, void *data)
  * @fwnode:	firmware node of the GPIO consumer
  * @con_id:	function within the GPIO consumer
  *
- * Return:
+ * Returns:
  * The number of GPIOs associated with a firmware node / function or %-ENOENT,
  * if no GPIO has been assigned to the requested function.
  */
diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index ef08b23a56e2..5aac59de0d76 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2748,7 +2748,9 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
  * gpio_chrdev_open() - open the chardev for ioctl operations
  * @inode: inode for this chardev
  * @file: file struct for storing private data
- * Returns 0 on success
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 static int gpio_chrdev_open(struct inode *inode, struct file *file)
 {
@@ -2814,7 +2816,9 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
  * gpio_chrdev_release() - close chardev after ioctl operations
  * @inode: inode for this chardev
  * @file: file struct for storing private data
- * Returns 0 on success
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 static int gpio_chrdev_release(struct inode *inode, struct file *file)
 {
diff --git a/drivers/gpio/gpiolib-devres.c b/drivers/gpio/gpiolib-devres.c
index 4987e62dcb3d..0fdf1356e717 100644
--- a/drivers/gpio/gpiolib-devres.c
+++ b/drivers/gpio/gpiolib-devres.c
@@ -52,6 +52,11 @@ static int devm_gpiod_match_array(struct device *dev, void *res, void *data)
  * Managed gpiod_get(). GPIO descriptors returned from this function are
  * automatically disposed on driver detach. See gpiod_get() for detailed
  * information about behavior and return values.
+ *
+ * Returns:
+ * The GPIO descriptor corresponding to the function @con_id of device
+ * dev, %-ENOENT if no GPIO has been assigned to the requested function, or
+ * another IS_ERR() code if an error occurred while trying to acquire the GPIO.
  */
 struct gpio_desc *__must_check devm_gpiod_get(struct device *dev,
 					      const char *con_id,
@@ -70,6 +75,11 @@ EXPORT_SYMBOL_GPL(devm_gpiod_get);
  * Managed gpiod_get_optional(). GPIO descriptors returned from this function
  * are automatically disposed on driver detach. See gpiod_get_optional() for
  * detailed information about behavior and return values.
+ *
+ * Returns:
+ * The GPIO descriptor corresponding to the function @con_id of device
+ * dev, NULL if no GPIO has been assigned to the requested function, or
+ * another IS_ERR() code if an error occurred while trying to acquire the GPIO.
  */
 struct gpio_desc *__must_check devm_gpiod_get_optional(struct device *dev,
 						       const char *con_id,
@@ -89,6 +99,11 @@ EXPORT_SYMBOL_GPL(devm_gpiod_get_optional);
  * Managed gpiod_get_index(). GPIO descriptors returned from this function are
  * automatically disposed on driver detach. See gpiod_get_index() for detailed
  * information about behavior and return values.
+ *
+ * Returns:
+ * The GPIO descriptor corresponding to the function @con_id of device
+ * dev, %-ENOENT if no GPIO has been assigned to the requested function, or
+ * another IS_ERR() code if an error occurred while trying to acquire the GPIO.
  */
 struct gpio_desc *__must_check devm_gpiod_get_index(struct device *dev,
 						    const char *con_id,
@@ -141,8 +156,10 @@ EXPORT_SYMBOL_GPL(devm_gpiod_get_index);
  * GPIO descriptors returned from this function are automatically disposed on
  * driver detach.
  *
- * On successful request the GPIO pin is configured in accordance with
- * provided @flags.
+ * Returns:
+ * The GPIO descriptor corresponding to the function @con_id of device
+ * dev, %-ENOENT if no GPIO has been assigned to the requested function, or
+ * another IS_ERR() code if an error occurred while trying to acquire the GPIO.
  */
 struct gpio_desc *devm_fwnode_gpiod_get_index(struct device *dev,
 					      struct fwnode_handle *fwnode,
@@ -182,6 +199,11 @@ EXPORT_SYMBOL_GPL(devm_fwnode_gpiod_get_index);
  * function are automatically disposed on driver detach. See
  * gpiod_get_index_optional() for detailed information about behavior and
  * return values.
+ *
+ * Returns:
+ * The GPIO descriptor corresponding to the function @con_id of device
+ * dev, %NULL if no GPIO has been assigned to the requested function, or
+ * another IS_ERR() code if an error occurred while trying to acquire the GPIO.
  */
 struct gpio_desc *__must_check devm_gpiod_get_index_optional(struct device *dev,
 							     const char *con_id,
@@ -207,6 +229,12 @@ EXPORT_SYMBOL_GPL(devm_gpiod_get_index_optional);
  * Managed gpiod_get_array(). GPIO descriptors returned from this function are
  * automatically disposed on driver detach. See gpiod_get_array() for detailed
  * information about behavior and return values.
+ *
+ * Returns:
+ * The GPIO descriptors corresponding to the function @con_id of device
+ * dev, %-ENOENT if no GPIO has been assigned to the requested function,
+ * or another IS_ERR() code if an error occurred while trying to acquire
+ * the GPIOs.
  */
 struct gpio_descs *__must_check devm_gpiod_get_array(struct device *dev,
 						     const char *con_id,
@@ -243,6 +271,12 @@ EXPORT_SYMBOL_GPL(devm_gpiod_get_array);
  * function are automatically disposed on driver detach.
  * See gpiod_get_array_optional() for detailed information about behavior and
  * return values.
+ *
+ * Returns:
+ * The GPIO descriptors corresponding to the function @con_id of device
+ * dev, %NULL if no GPIO has been assigned to the requested function,
+ * or another IS_ERR() code if an error occurred while trying to acquire
+ * the GPIOs.
  */
 struct gpio_descs *__must_check
 devm_gpiod_get_array_optional(struct device *dev, const char *con_id,
diff --git a/drivers/gpio/gpiolib-legacy.c b/drivers/gpio/gpiolib-legacy.c
index f421208ddbdd..087fe3227e35 100644
--- a/drivers/gpio/gpiolib-legacy.c
+++ b/drivers/gpio/gpiolib-legacy.c
@@ -22,6 +22,9 @@ EXPORT_SYMBOL_GPL(gpio_free);
  * @label:	a literal description string of this GPIO
  *
  * **DEPRECATED** This function is deprecated and must not be used in new code.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpio_request_one(unsigned gpio, unsigned long flags, const char *label)
 {
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index d0d78e0fa28c..880f1efcaca5 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -46,16 +46,19 @@ enum of_gpio_flags {
  * @propname:	property name containing gpio specifier(s)
  *
  * The function returns the count of GPIOs specified for a node.
- * Note that the empty GPIO specifiers count too. Returns either
- *   Number of gpios defined in property,
- *   -EINVAL for an incorrectly formed gpios property, or
- *   -ENOENT for a missing gpios property
+ * NOTE: The empty GPIO specifiers count too.
  *
- * Example:
- * gpios = <0
- *          &gpio1 1 2
- *          0
- *          &gpio2 3 4>;
+ * Returns:
+ * Either number of GPIOs defined in the property, or
+ * *  %-EINVAL for an incorrectly formed "gpios" property, or
+ * *  %-ENOENT for a missing "gpios" property.
+ *
+ * Example::
+ *
+ *     gpios = <0
+ *              &gpio1 1 2
+ *              0
+ *              &gpio2 3 4>;
  *
  * The above example defines four GPIOs, two of which are not specified.
  * This function will return '4'
@@ -77,6 +80,11 @@ static int of_gpio_named_count(const struct device_node *np,
  * "gpios" for the chip select lines. If we detect this, we redirect
  * the counting of "cs-gpios" to count "gpios" transparent to the
  * driver.
+ *
+ * Returns:
+ * Either number of GPIOs defined in the property, or
+ * *  %-EINVAL for an incorrectly formed "gpios" property, or
+ * *  %-ENOENT for a missing "gpios" property.
  */
 static int of_gpio_spi_cs_get_count(const struct device_node *np,
 				    const char *con_id)
@@ -373,7 +381,8 @@ static void of_gpio_flags_quirks(const struct device_node *np,
  * @index:	index of the GPIO
  * @flags:	a flags pointer to fill in
  *
- * Returns GPIO descriptor to use with Linux GPIO API, or one of the errno
+ * Returns:
+ * GPIO descriptor to use with Linux GPIO API, or one of the errno
  * value on the error condition. If @flags is not NULL the function also fills
  * in flags for the GPIO.
  */
@@ -425,7 +434,8 @@ static struct gpio_desc *of_get_named_gpiod_flags(const struct device_node *np,
  *
  * **DEPRECATED** This function is deprecated and must not be used in new code.
  *
- * Returns GPIO number to use with Linux generic GPIO API, or one of the errno
+ * Returns:
+ * GPIO number to use with Linux generic GPIO API, or one of the errno
  * value on the error condition.
  */
 int of_get_named_gpio(const struct device_node *np, const char *propname,
@@ -711,7 +721,8 @@ struct gpio_desc *of_find_gpio(struct device_node *np, const char *con_id,
  *		of_find_gpio() or of_parse_own_gpio()
  * @dflags:	gpiod_flags - optional GPIO initialization flags
  *
- * Returns GPIO descriptor to use with Linux GPIO API, or one of the errno
+ * Returns:
+ * GPIO descriptor to use with Linux GPIO API, or one of the errno
  * value on the error condition.
  */
 static struct gpio_desc *of_parse_own_gpio(struct device_node *np,
@@ -779,7 +790,8 @@ static struct gpio_desc *of_parse_own_gpio(struct device_node *np,
  * @chip:	gpio chip to act on
  * @hog:	device node describing the hogs
  *
- * Returns error if it fails otherwise 0 on success.
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 static int of_gpiochip_add_hog(struct gpio_chip *chip, struct device_node *hog)
 {
@@ -813,7 +825,9 @@ static int of_gpiochip_add_hog(struct gpio_chip *chip, struct device_node *hog)
  *
  * This is only used by of_gpiochip_add to request/set GPIO initial
  * configuration.
- * It returns error if it fails otherwise 0 on success.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 static int of_gpiochip_scan_gpios(struct gpio_chip *chip)
 {
@@ -923,6 +937,9 @@ struct notifier_block gpio_of_notifier = {
  * This is simple translation function, suitable for the most 1:1 mapped
  * GPIO chips. This function performs only one sanity check: whether GPIO
  * is less than ngpios (that is specified in the gpio_chip).
+ *
+ * Returns:
+ * GPIO number (>= 0) on success, negative errno on failure.
  */
 static int of_gpio_simple_xlate(struct gpio_chip *gc,
 				const struct of_phandle_args *gpiospec,
@@ -972,6 +989,9 @@ static int of_gpio_simple_xlate(struct gpio_chip *gc,
  * If succeeded, this function will map bank's memory and will
  * do all necessary work for you. Then you'll able to use .regs
  * to manage GPIOs from the callbacks.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int of_mm_gpiochip_add_data(struct device_node *np,
 			    struct of_mm_gpio_chip *mm_gc,
diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
index 1a6f70671816..2b2dd7e92211 100644
--- a/drivers/gpio/gpiolib-swnode.c
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -106,7 +106,7 @@ struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
  *		system-global GPIOs
  * @con_id:	function within the GPIO consumer
  *
- * Return:
+ * Returns:
  * The number of GPIOs associated with a device / function or %-ENOENT,
  * if no GPIO has been assigned to the requested function.
  */
diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 26202586fd39..17ed229412af 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -568,7 +568,8 @@ static struct class gpio_class = {
  * will see "direction" sysfs attribute which may be used to change
  * the gpio's direction.  A "value" attribute will always be provided.
  *
- * Returns zero on success, else an error.
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 {
@@ -667,7 +668,8 @@ static int match_export(struct device *dev, const void *desc)
  * Set up a symlink from /sys/.../dev/name to /sys/class/gpio/gpioN
  * node. Caller is responsible for unlinking.
  *
- * Returns zero on success, else an error.
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_export_link(struct device *dev, const char *name,
 		      struct gpio_desc *desc)
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 3903d0a75304..77ab0b6810eb 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -230,6 +230,9 @@ EXPORT_SYMBOL_GPL(desc_to_gpio);
  * This function is unsafe and should not be used. Using the chip address
  * without taking the SRCU read lock may result in dereferencing a dangling
  * pointer.
+ *
+ * Returns:
+ * Address of the GPIO chip backing this device.
  */
 struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc)
 {
@@ -342,7 +345,8 @@ static int gpiochip_find_base_unlocked(u16 ngpio)
  * gpiod_get_direction - return the current direction of a GPIO
  * @desc:	GPIO to get the direction of
  *
- * Returns 0 for output, 1 for input, or an error code in case of error.
+ * Returns:
+ * 0 for output, 1 for input, or an error code in case of error.
  *
  * This function may sleep if gpiod_cansleep() is true.
  */
@@ -399,8 +403,8 @@ EXPORT_SYMBOL_GPL(gpiod_get_direction);
  * Add a new chip to the global chips list, keeping the list of chips sorted
  * by range(means [base, base + ngpio - 1]) order.
  *
- * Return -EBUSY if the new chip overlaps with some other chip's integer
- * space.
+ * Returns:
+ * -EBUSY if the new chip overlaps with some other chip's integer space.
  */
 static int gpiodev_add_to_list_unlocked(struct gpio_device *gdev)
 {
@@ -1516,6 +1520,9 @@ static unsigned int gpiochip_child_offset_to_irq_noop(struct gpio_chip *gc,
  * This function is a wrapper that calls gpiochip_lock_as_irq() and is to be
  * used as the activate function for the &struct irq_domain_ops. The host_data
  * for the IRQ domain must be the &struct gpio_chip.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 static int gpiochip_irq_domain_activate(struct irq_domain *domain,
 					struct irq_data *data, bool reserve)
@@ -1660,6 +1667,9 @@ static bool gpiochip_hierarchy_is_hierarchical(struct gpio_chip *gc)
  * This function will set up the mapping for a certain IRQ line on a
  * gpiochip by assigning the gpiochip as chip data, and using the irqchip
  * stored inside the gpiochip.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 static int gpiochip_irq_map(struct irq_domain *d, unsigned int irq,
 			    irq_hw_number_t hwirq)
@@ -1894,6 +1904,9 @@ static int gpiochip_irqchip_add_allocated_domain(struct gpio_chip *gc,
  * @gc: the GPIO chip to add the IRQ chip to
  * @lock_key: lockdep class for IRQ lock
  * @request_key: lockdep class for IRQ request
+ *
+ * Returns:
+ * 0 on success, or a negative errno on failure.
  */
 static int gpiochip_add_irqchip(struct gpio_chip *gc,
 				struct lock_class_key *lock_key,
@@ -2029,6 +2042,9 @@ static void gpiochip_irqchip_remove(struct gpio_chip *gc)
  * @domain: the irqdomain to add to the gpiochip
  *
  * This function adds an IRQ domain to the gpiochip.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
 				struct irq_domain *domain)
@@ -2065,6 +2081,9 @@ static inline void gpiochip_irqchip_free_valid_mask(struct gpio_chip *gc)
  * gpiochip_generic_request() - request the gpio function for a pin
  * @gc: the gpiochip owning the GPIO
  * @offset: the offset of the GPIO to request for GPIO function
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiochip_generic_request(struct gpio_chip *gc, unsigned int offset)
 {
@@ -2098,6 +2117,9 @@ EXPORT_SYMBOL_GPL(gpiochip_generic_free);
  * @gc: the gpiochip owning the GPIO
  * @offset: the offset of the GPIO to apply the configuration
  * @config: the configuration to be applied
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiochip_generic_config(struct gpio_chip *gc, unsigned int offset,
 			    unsigned long config)
@@ -2124,6 +2146,9 @@ EXPORT_SYMBOL_GPL(gpiochip_generic_config);
  * pinctrl driver is DEPRECATED. Please see Section 2.1 of
  * Documentation/devicetree/bindings/gpio/gpio.txt on how to
  * bind pinctrl and gpio drivers via the "gpio-ranges" property.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiochip_add_pingroup_range(struct gpio_chip *gc,
 			struct pinctrl_dev *pctldev,
@@ -2175,13 +2200,13 @@ EXPORT_SYMBOL_GPL(gpiochip_add_pingroup_range);
  * @npins: the number of pins from the offset of each pin space (GPIO and
  *	pin controller) to accumulate in this range
  *
- * Returns:
- * 0 on success, or a negative error-code on failure.
- *
  * Calling this function directly from a DeviceTree-supported
  * pinctrl driver is DEPRECATED. Please see Section 2.1 of
  * Documentation/devicetree/bindings/gpio/gpio.txt on how to
  * bind pinctrl and gpio drivers via the "gpio-ranges" property.
+ *
+ * Returns:
+ * 0 on success, or a negative errno on failure.
  */
 int gpiochip_add_pin_range(struct gpio_chip *gc, const char *pinctl_name,
 			   unsigned int gpio_offset, unsigned int pin_offset,
@@ -2585,7 +2610,8 @@ static int gpio_set_bias(struct gpio_desc *desc)
  * The function calls the certain GPIO driver to set debounce timeout
  * in the hardware.
  *
- * Returns 0 on success, or negative error code otherwise.
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce)
 {
@@ -2601,7 +2627,8 @@ int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce)
  * Set the direction of the passed GPIO to input, such as gpiod_get_value() can
  * be called safely on it.
  *
- * Return 0 in case of success, else an error code.
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_direction_input(struct gpio_desc *desc)
 {
@@ -2708,7 +2735,8 @@ static int gpiod_direction_output_raw_commit(struct gpio_desc *desc, int value)
  * be called safely on it. The initial value of the output must be specified
  * as raw value on the physical line without regard for the ACTIVE_LOW status.
  *
- * Return 0 in case of success, else an error code.
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_direction_output_raw(struct gpio_desc *desc, int value)
 {
@@ -2727,7 +2755,8 @@ EXPORT_SYMBOL_GPL(gpiod_direction_output_raw);
  * as the logical value of the GPIO, i.e. taking its ACTIVE_LOW status into
  * account.
  *
- * Return 0 in case of success, else an error code.
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_direction_output(struct gpio_desc *desc, int value)
 {
@@ -2800,7 +2829,8 @@ EXPORT_SYMBOL_GPL(gpiod_direction_output);
  * @desc: GPIO to enable.
  * @flags: Flags related to GPIO edge.
  *
- * Return 0 in case of success, else negative error code.
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_enable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags)
 {
@@ -2832,7 +2862,8 @@ EXPORT_SYMBOL_GPL(gpiod_enable_hw_timestamp_ns);
  * @desc: GPIO to disable.
  * @flags: Flags related to GPIO edge, same value as used during enable call.
  *
- * Return 0 in case of success, else negative error code.
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags)
 {
@@ -2924,7 +2955,8 @@ int gpiod_set_transitory(struct gpio_desc *desc, bool transitory)
  * gpiod_is_active_low - test whether a GPIO is active-low or not
  * @desc: the gpio descriptor to test
  *
- * Returns 1 if the GPIO is active-low, 0 otherwise.
+ * Returns:
+ * 1 if the GPIO is active-low, 0 otherwise.
  */
 int gpiod_is_active_low(const struct gpio_desc *desc)
 {
@@ -3139,7 +3171,8 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
  * gpiod_get_raw_value() - return a gpio's raw value
  * @desc: gpio whose value will be returned
  *
- * Return the GPIO's raw value, i.e. the value of the physical line disregarding
+ * Returns:
+ * The GPIO's raw value, i.e. the value of the physical line disregarding
  * its ACTIVE_LOW status, or negative errno on failure.
  *
  * This function can be called from contexts where we cannot sleep, and will
@@ -3158,7 +3191,8 @@ EXPORT_SYMBOL_GPL(gpiod_get_raw_value);
  * gpiod_get_value() - return a gpio's value
  * @desc: gpio whose value will be returned
  *
- * Return the GPIO's logical value, i.e. taking the ACTIVE_LOW status into
+ * Returns:
+ * The GPIO's logical value, i.e. taking the ACTIVE_LOW status into
  * account, or negative errno on failure.
  *
  * This function can be called from contexts where we cannot sleep, and will
@@ -3191,11 +3225,13 @@ EXPORT_SYMBOL_GPL(gpiod_get_value);
  * @value_bitmap: bitmap to store the read values
  *
  * Read the raw values of the GPIOs, i.e. the values of the physical lines
- * without regard for their ACTIVE_LOW status.  Return 0 in case of success,
- * else an error code.
+ * without regard for their ACTIVE_LOW status.
  *
  * This function can be called from contexts where we cannot sleep,
  * and it will complain if the GPIO chip functions potentially sleep.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_get_raw_array_value(unsigned int array_size,
 			      struct gpio_desc **desc_array,
@@ -3218,10 +3254,13 @@ EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value);
  * @value_bitmap: bitmap to store the read values
  *
  * Read the logical values of the GPIOs, i.e. taking their ACTIVE_LOW status
- * into account.  Return 0 in case of success, else an error code.
+ * into account.
  *
  * This function can be called from contexts where we cannot sleep,
  * and it will complain if the GPIO chip functions potentially sleep.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_get_array_value(unsigned int array_size,
 			  struct gpio_desc **desc_array,
@@ -3509,6 +3548,9 @@ EXPORT_SYMBOL_GPL(gpiod_set_value);
  *
  * This function can be called from contexts where we cannot sleep, and will
  * complain if the GPIO chip functions potentially sleep.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_set_raw_array_value(unsigned int array_size,
 			      struct gpio_desc **desc_array,
@@ -3534,6 +3576,9 @@ EXPORT_SYMBOL_GPL(gpiod_set_raw_array_value);
  *
  * This function can be called from contexts where we cannot sleep, and will
  * complain if the GPIO chip functions potentially sleep.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_set_array_value(unsigned int array_size,
 			  struct gpio_desc **desc_array,
@@ -3552,6 +3597,8 @@ EXPORT_SYMBOL_GPL(gpiod_set_array_value);
  * gpiod_cansleep() - report whether gpio value access may sleep
  * @desc: gpio to check
  *
+ * Returns:
+ * 0 for non-sleepable, 1 for sleepable, or an error code in case of error.
  */
 int gpiod_cansleep(const struct gpio_desc *desc)
 {
@@ -3564,6 +3611,9 @@ EXPORT_SYMBOL_GPL(gpiod_cansleep);
  * gpiod_set_consumer_name() - set the consumer name for the descriptor
  * @desc: gpio to set the consumer name on
  * @name: the new consumer name
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_set_consumer_name(struct gpio_desc *desc, const char *name)
 {
@@ -3577,8 +3627,8 @@ EXPORT_SYMBOL_GPL(gpiod_set_consumer_name);
  * gpiod_to_irq() - return the IRQ corresponding to a GPIO
  * @desc: gpio whose IRQ will be returned (already requested)
  *
- * Return the IRQ corresponding to the passed GPIO, or an error code in case of
- * error.
+ * Returns:
+ * The IRQ corresponding to the passed GPIO, or an error code in case of error.
  */
 int gpiod_to_irq(const struct gpio_desc *desc)
 {
@@ -3632,6 +3682,9 @@ EXPORT_SYMBOL_GPL(gpiod_to_irq);
  *
  * This is used directly by GPIO drivers that want to lock down
  * a certain GPIO line to be used for IRQs.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiochip_lock_as_irq(struct gpio_chip *gc, unsigned int offset)
 {
@@ -3783,7 +3836,8 @@ EXPORT_SYMBOL_GPL(gpiochip_line_is_persistent);
  * gpiod_get_raw_value_cansleep() - return a gpio's raw value
  * @desc: gpio whose value will be returned
  *
- * Return the GPIO's raw value, i.e. the value of the physical line disregarding
+ * Returns:
+ * The GPIO's raw value, i.e. the value of the physical line disregarding
  * its ACTIVE_LOW status, or negative errno on failure.
  *
  * This function is to be called from contexts that can sleep.
@@ -3800,7 +3854,8 @@ EXPORT_SYMBOL_GPL(gpiod_get_raw_value_cansleep);
  * gpiod_get_value_cansleep() - return a gpio's value
  * @desc: gpio whose value will be returned
  *
- * Return the GPIO's logical value, i.e. taking the ACTIVE_LOW status into
+ * Returns:
+ * The GPIO's logical value, i.e. taking the ACTIVE_LOW status into
  * account, or negative errno on failure.
  *
  * This function is to be called from contexts that can sleep.
@@ -3830,10 +3885,12 @@ EXPORT_SYMBOL_GPL(gpiod_get_value_cansleep);
  * @value_bitmap: bitmap to store the read values
  *
  * Read the raw values of the GPIOs, i.e. the values of the physical lines
- * without regard for their ACTIVE_LOW status.  Return 0 in case of success,
- * else an error code.
+ * without regard for their ACTIVE_LOW status.
  *
  * This function is to be called from contexts that can sleep.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
 				       struct gpio_desc **desc_array,
@@ -3857,9 +3914,12 @@ EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value_cansleep);
  * @value_bitmap: bitmap to store the read values
  *
  * Read the logical values of the GPIOs, i.e. taking their ACTIVE_LOW status
- * into account.  Return 0 in case of success, else an error code.
+ * into account.
  *
  * This function is to be called from contexts that can sleep.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_get_array_value_cansleep(unsigned int array_size,
 				   struct gpio_desc **desc_array,
@@ -3922,6 +3982,9 @@ EXPORT_SYMBOL_GPL(gpiod_set_value_cansleep);
  * without regard for their ACTIVE_LOW status.
  *
  * This function is to be called from contexts that can sleep.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 				       struct gpio_desc **desc_array,
@@ -3964,6 +4027,9 @@ void gpiod_add_lookup_tables(struct gpiod_lookup_table **tables, size_t n)
  * into account.
  *
  * This function is to be called from contexts that can sleep.
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_set_array_value_cansleep(unsigned int array_size,
 				   struct gpio_desc **desc_array,
@@ -4297,9 +4363,12 @@ EXPORT_SYMBOL_GPL(fwnode_gpiod_get_index);
 
 /**
  * gpiod_count - return the number of GPIOs associated with a device / function
- *		or -ENOENT if no GPIO has been assigned to the requested function
  * @dev:	GPIO consumer, can be NULL for system-global GPIOs
  * @con_id:	function within the GPIO consumer
+ *
+ * Returns:
+ * The number of GPIOs associated with a device / function or -ENOENT if no
+ * GPIO has been assigned to the requested function.
  */
 int gpiod_count(struct device *dev, const char *con_id)
 {
@@ -4326,7 +4395,8 @@ EXPORT_SYMBOL_GPL(gpiod_count);
  * @con_id:	function within the GPIO consumer
  * @flags:	optional GPIO initialization flags
  *
- * Return the GPIO descriptor corresponding to the function con_id of device
+ * Returns:
+ * The GPIO descriptor corresponding to the function @con_id of device
  * dev, -ENOENT if no GPIO has been assigned to the requested function, or
  * another IS_ERR() code if an error occurred while trying to acquire the GPIO.
  */
@@ -4346,6 +4416,11 @@ EXPORT_SYMBOL_GPL(gpiod_get);
  * This is equivalent to gpiod_get(), except that when no GPIO was assigned to
  * the requested function it will return NULL. This is convenient for drivers
  * that need to handle optional GPIOs.
+ *
+ * Returns:
+ * The GPIO descriptor corresponding to the function @con_id of device
+ * dev, NULL if no GPIO has been assigned to the requested function, or
+ * another IS_ERR() code if an error occurred while trying to acquire the GPIO.
  */
 struct gpio_desc *__must_check gpiod_get_optional(struct device *dev,
 						  const char *con_id,
@@ -4364,7 +4439,8 @@ EXPORT_SYMBOL_GPL(gpiod_get_optional);
  *		of_find_gpio() or of_get_gpio_hog()
  * @dflags:	gpiod_flags - optional GPIO initialization flags
  *
- * Return 0 on success, -ENOENT if no GPIO has been assigned to the
+ * Returns:
+ * 0 on success, -ENOENT if no GPIO has been assigned to the
  * requested function and/or index, or another IS_ERR() code if an error
  * occurred while trying to acquire the GPIO.
  */
@@ -4439,7 +4515,8 @@ int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
  * This variant of gpiod_get() allows to access GPIOs other than the first
  * defined one for functions that define several GPIOs.
  *
- * Return a valid GPIO descriptor, -ENOENT if no GPIO has been assigned to the
+ * Returns:
+ * A valid GPIO descriptor, -ENOENT if no GPIO has been assigned to the
  * requested function and/or index, or another IS_ERR() code if an error
  * occurred while trying to acquire the GPIO.
  */
@@ -4467,6 +4544,11 @@ EXPORT_SYMBOL_GPL(gpiod_get_index);
  * This is equivalent to gpiod_get_index(), except that when no GPIO with the
  * specified index was assigned to the requested function it will return NULL.
  * This is convenient for drivers that need to handle optional GPIOs.
+ *
+ * Returns:
+ * A valid GPIO descriptor, NULL if no GPIO has been assigned to the
+ * requested function and/or index, or another IS_ERR() code if an error
+ * occurred while trying to acquire the GPIO.
  */
 struct gpio_desc *__must_check gpiod_get_index_optional(struct device *dev,
 							const char *con_id,
@@ -4490,6 +4572,9 @@ EXPORT_SYMBOL_GPL(gpiod_get_index_optional);
  * @lflags:	bitmask of gpio_lookup_flags GPIO_* values - returned from
  *		of_find_gpio() or of_get_gpio_hog()
  * @dflags:	gpiod_flags - optional GPIO initialization flags
+ *
+ * Returns:
+ * 0 on success, or negative errno on failure.
  */
 int gpiod_hog(struct gpio_desc *desc, const char *name,
 	      unsigned long lflags, enum gpiod_flags dflags)
@@ -4546,9 +4631,11 @@ static void gpiochip_free_hogs(struct gpio_chip *gc)
  *
  * This function acquires all the GPIOs defined under a given function.
  *
- * Return a struct gpio_descs containing an array of descriptors, -ENOENT if
- * no GPIO has been assigned to the requested function, or another IS_ERR()
- * code if an error occurred while trying to acquire the GPIOs.
+ * Returns:
+ * The GPIO descriptors corresponding to the function @con_id of device
+ * dev, -ENOENT if no GPIO has been assigned to the requested function,
+ * or another IS_ERR() code if an error occurred while trying to acquire
+ * the GPIOs.
  */
 struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 						const char *con_id,
@@ -4674,6 +4761,12 @@ EXPORT_SYMBOL_GPL(gpiod_get_array);
  *
  * This is equivalent to gpiod_get_array(), except that when no GPIO was
  * assigned to the requested function it will return NULL.
+ *
+ * Returns:
+ * The GPIO descriptors corresponding to the function @con_id of device
+ * dev, NULL if no GPIO has been assigned to the requested function,
+ * or another IS_ERR() code if an error occurred while trying to acquire
+ * the GPIOs.
  */
 struct gpio_descs *__must_check gpiod_get_array_optional(struct device *dev,
 							const char *con_id,
-- 
2.43.0.rc1.1336.g36b5255a03ac


