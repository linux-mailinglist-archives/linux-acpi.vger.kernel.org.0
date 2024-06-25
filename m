Return-Path: <linux-acpi+bounces-6612-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 868DE9173E3
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jun 2024 23:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061151F234EB
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jun 2024 21:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD72E17E914;
	Tue, 25 Jun 2024 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="m/2r1PS0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2A617D360;
	Tue, 25 Jun 2024 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719352591; cv=none; b=p8h4U4j4Q1YQansx2e6IUNAgHBOneex+/CUfokz72rOgeP26EhRc0SanUR1fd+lCWweHxegYO+LnUlvRtIHA51xuslfblohreL/1QQNNqQ6utDqPlNOeiJK/ScfFH0dw6KG01HoJI7e3efr/624XJqJ0yJSqbyvfwIpS2HXPGaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719352591; c=relaxed/simple;
	bh=hkbRPr9eyUyc8TLpwKSS/o8S448gatXw3MGVmqVjO/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWm0zj4nIYR9hbLfPEpIpgwSnaJZpKYvl2ShRZlyOVcbGWQHOEfd5G1tNWkP0zbWblfultYStIo8T8C+s4zy81RFHcNvhK0EXiw2ZxPT2R98Ayz59rORZPqIs7Ldps9WKDlcc/HaaDdCWc4Rya/zVqHNpCKNYdaMZIA6YaKzPxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=m/2r1PS0; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1719352578;
	bh=hkbRPr9eyUyc8TLpwKSS/o8S448gatXw3MGVmqVjO/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/2r1PS0nsz0Z1m0TULDFaAqsus2d4gADFfrMbLJi89AoGisxUgqLUqxIwvBv+q9p
	 O1achJBVWW4uVSwzBWphop3y5mJvAhlhJQqiF00aRpuX0LK4BOOVmt6WqVcDGMzb8T
	 sazVAV2+BAOozEDAX00XBXb0juEJ9X7murWv/gcs=
Date: Tue, 25 Jun 2024 23:56:18 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linux.dev, Aishwarya.TCV@arm.com
Subject: Re: [PATCH 2/5] ACPI: sysfs: use device lifecycle for _STR result
Message-ID: <111f7a2c-403b-40b3-9e25-8c4a040d8dfb@t-8ch.de>
References: <20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net>
 <20240613-acpi-sysfs-groups-v1-2-665e0deb052a@weissschuh.net>
 <a72495c3-c996-4be7-bc64-ba10d5400971@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a72495c3-c996-4be7-bc64-ba10d5400971@sirena.org.uk>

On 2024-06-25 21:57:13+0000, Mark Brown wrote:
> On Thu, Jun 13, 2024 at 10:15:33PM +0200, Thomas Weißschuh wrote:
> > The string assigned to dev->pnp.str effectively shares the lifetime of
> > the device. Use devm_-APIs to avoid a manual cleanup path.
> > 
> > This will be useful when the attributes themselves will be managed by
> > the device core.
> 
> This is in -next since 20240624 and appears to be causing issues on
> Cavium Thunder X2 in the Arm lab - with arm64 defconfig we see a bunch
> of log messages like:
> 
> <6>[   50.120962] ACPI: button: Power Button [PWRB]
> <6>[   50.120962] ACPI: button: Power Button [PWRB]
> <2>[   50.138595] acpi LNXTHERM:00: Resources present before probing
> <2>[   50.138595] acpi LNXTHERM:00: Resources present before probing
> <2>[   50.150873] acpi LNXTHERM:01: Resources present before probing
> <2>[   50.150873] acpi LNXTHERM:01: Resources present before probing
> <2>[   50.163134] acpi LNXTHERM:02: Resources present before probing
> <2>[   50.163134] acpi LNXTHERM:02: Resources present before probing
> <2>[   50.175393] acpi LNXTHERM:03: Resources present before probing
> <2>[   50.175393] acpi LNXTHERM:03: Resources present before probing
> <2>[   50.187653] acpi LNXTHERM:04: Resources present before probing
> <2>[   50.187653] acpi LNXTHERM:04: Resources present before probing
> <2>[   50.199913] acpi LNXTHERM:05: Resources present before probing
> <2>[   50.199913] acpi LNXTHERM:05: Resources present before probing
> <2>[   50.212171] acpi LNXTHERM:06: Resources present before probing
> <2>[   50.212171] acpi LNXTHERM:06: Resources present before probing
> <2>[   50.224433] acpi LNXTHERM:07: Resources present before probing
> <2>[   50.224433] acpi LNXTHERM:07: Resources present before probing
> <2>[   50.236703] acpi LNXTHERM:08: Resources present before probing

This does make sense, the device is not yet bound to a driver.
Which apparently precludes the usage of devres.

Skipping this commit and doing the kfree() inside
acpi_device_remove_file() also shouldn't work, as the attributes would
live longer than the string.

I'm wondering why dev->pnp.str does not share the lifecycle of the
rest of dev->pnp, acpi_init_device_object()/acpi_device_release().

Or we evaluate _STR during is_visible(), which keeps the single
evaluation, or during description_show() which is the same as all the
other attributes.

I'm also wondering why the _STR attribute behaved differently in the
first place.
Does the patch below work better?

> (some other bug seems to be doubling all the log lines.)  We also see
> PCI getting upset:
> 
> <6>[   50.238119] pcieport 0000:00:03.0: Refused to change power state from D0 to D3hot
> 
> and the ethernet driver gets confused:
> 
> [ 71.592299] mlx5_core 0000:0b:00.1: Port module event: module 1, Cable unplugged
> 
> while the cable is most definitely connected, we're netbooting.  A
> bisect pointed at this commit, full bisect log below:

All these different kinds of errors are bisected to this commit?


diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index c85ec754931c..350915b06472 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -510,6 +510,40 @@ static struct attribute *acpi_attrs[] = {
 	NULL
 };
 
+static const char *acpi_device_str(struct acpi_device *dev)
+{
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *str_obj;
+	acpi_status status;
+	const char *ret;
+	char buf[512];
+	int result;
+
+	if (!acpi_has_method(dev->handle, "_STR"))
+		return NULL;
+
+	status = acpi_evaluate_object(dev->handle, "_STR",
+				      NULL, &buffer);
+	if (ACPI_FAILURE(status))
+		return NULL;
+
+	str_obj = buffer.pointer;
+	/*
+	 * The _STR object contains a Unicode identifier for a device.
+	 * We need to convert to utf-8 so it can be displayed.
+	 */
+	result = utf16s_to_utf8s((wchar_t *)str_obj->buffer.pointer,
+				 str_obj->buffer.length,
+				 UTF16_LITTLE_ENDIAN,
+				 buf, sizeof(buf) - 1);
+	buf[result++] = '\0';
+
+	ret = kstrdup(buf, GFP_KERNEL);
+	kfree(buffer.pointer);
+
+	return ret;
+}
+
 static bool acpi_show_attr(struct acpi_device *dev, const struct device_attribute *attr)
 {
 	/*
@@ -524,8 +558,11 @@ static bool acpi_show_attr(struct acpi_device *dev, const struct device_attribut
 	/*
 	 * If device has _STR, 'description' file is created
 	 */
-	if (attr == &dev_attr_description)
+	if (attr == &dev_attr_description) {
+		kfree(dev->pnp.str);
+		dev->pnp.str = acpi_device_str(dev);
 		return dev->pnp.str;
+	}
 
 	if (attr == &dev_attr_adr)
 		return dev->pnp.type.bus_address;
@@ -581,47 +618,12 @@ const struct attribute_group *acpi_groups[] = {
 	NULL
 };
 
-static const char *devm_acpi_device_str(struct acpi_device *dev)
-{
-	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
-	union acpi_object *str_obj;
-	acpi_status status;
-	const char *ret;
-	char buf[512];
-	int result;
-
-	if (!acpi_has_method(dev->handle, "_STR"))
-		return NULL;
-
-	status = acpi_evaluate_object(dev->handle, "_STR",
-				      NULL, &buffer);
-	if (ACPI_FAILURE(status))
-		return NULL;
-
-	str_obj = buffer.pointer;
-	/*
-	 * The _STR object contains a Unicode identifier for a device.
-	 * We need to convert to utf-8 so it can be displayed.
-	 */
-	result = utf16s_to_utf8s((wchar_t *)str_obj->buffer.pointer,
-				 str_obj->buffer.length,
-				 UTF16_LITTLE_ENDIAN,
-				 buf, sizeof(buf) - 1);
-	buf[result++] = '\0';
-
-	ret = devm_kstrdup(&dev->dev, buf, GFP_KERNEL);
-	kfree(buffer.pointer);
-
-	return ret;
-}
-
 /**
  * acpi_device_setup_files - Create sysfs attributes of an ACPI device.
  * @dev: ACPI device object.
  */
 void acpi_device_setup_files(struct acpi_device *dev)
 {
-	dev->pnp.str = devm_acpi_device_str(dev);
 	acpi_expose_nondev_subnodes(&dev->dev.kobj, &dev->data);
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 49a8172fe0de..84c4190f03fb 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1456,6 +1456,7 @@ void acpi_free_pnp_ids(struct acpi_device_pnp *pnp)
 		kfree(id);
 	}
 	kfree(pnp->unique_id);
+	kfree(pnp->str);
 }
 
 /**

