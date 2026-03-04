Return-Path: <linux-acpi+bounces-21344-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ2pIcF9qGluvAAAu9opvQ
	(envelope-from <linux-acpi+bounces-21344-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:45:21 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E306B206914
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4716230FAB0F
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 18:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C948B3D567A;
	Wed,  4 Mar 2026 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnX9G5IJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A645938D;
	Wed,  4 Mar 2026 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772649214; cv=none; b=hqMhalWqMg+FwhU7SRGJT4bApoZRE/v3h+TrDeu0xhCAMsmAzphtq1QjgY2zgAEbzkb/JKST//VLQpsM9s20JfUD7dWqyZeSX2zzKlWVjIRVAjYv66OIiymGPtHNC8edqyPsS5zE5e2Wnvw8nlNn+wD3e1f2pv8OcZzh6JEm05s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772649214; c=relaxed/simple;
	bh=TYl+mO3jTFF78LYOjZjVzDB4wpiR2tpbrL1fIlmPiw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ergOmQTsJhyz/HGQZTqagQq5b1vW9nSeYZQCci+N54qEfw6BRj2JgaeETUkRSXsmzP7veqOwwfm2/23FLc/gkGGtMnNWnnlYWA6poK0/TBMeX5fh9q37WZCDb8qpfRFrAn1qoqL/XOH3TujoXfxrCbcPyUPnFesH6vMWpQ44Exg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnX9G5IJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926C8C2BC86;
	Wed,  4 Mar 2026 18:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772649214;
	bh=TYl+mO3jTFF78LYOjZjVzDB4wpiR2tpbrL1fIlmPiw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VnX9G5IJHIAqJiwhY41wj5R4TfHMaDqE1ii9AaTSrwbv9iJ6Qm6oVz4hv7ocV/vmt
	 VRZ3taxDfjg+Ber5v2pNFgLcj5f8o7BvJpYRaZbEhcXyJ1CWRTOYyHG7TqQR4Uy6od
	 M2uP0TOg5Q5HTVSuJDStc/eiP9cm4OOiDsMjqBDcfN2HdDM9RA0I5dNsId2azETua2
	 ToP2BliSOPPXXSHgNYlwnPG3Hi22i5Q0h2quUkT7T2bFlaOVCEsCR7TlKRwezsvGY6
	 52pLVgqttK0B0aVfZNqjdqW471CRFbA/MNe+4WFhLFBwdC3VFVhbFUsiJnVP7tYt/s
	 UPGtErk6TBQzw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org
Subject:
 [PATCH v1 1/2] iio: light: acpi-als: Register ACPI notify handler directly
Date: Wed, 04 Mar 2026 19:32:26 +0100
Message-ID: <8702898.NyiUUSuA9g@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6147175.MhkbZ0Pkbq@rafael.j.wysocki>
References: <6147175.MhkbZ0Pkbq@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E306B206914
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21344-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,rafael.j.wysocki:mid]
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

To facilitate subsequent conversion of the driver to a platform one,
make it install an ACPI notify handler directly instead of using
a .notify() callback in struct acpi_driver.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/iio/light/acpi-als.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index d5d1a8b9c035..2fe6b493c012 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -90,9 +90,9 @@ static int acpi_als_read_value(struct acpi_als *als, char *prop, s32 *val)
 	return 0;
 }
 
-static void acpi_als_notify(struct acpi_device *device, u32 event)
+static void acpi_als_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct iio_dev *indio_dev = acpi_driver_data(device);
+	struct iio_dev *indio_dev = data;
 	struct acpi_als *als = iio_priv(indio_dev);
 
 	if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev)) {
@@ -102,7 +102,7 @@ static void acpi_als_notify(struct acpi_device *device, u32 event)
 			break;
 		default:
 			/* Unhandled event */
-			dev_dbg(&device->dev,
+			dev_dbg(&als->device->dev,
 				"Unhandled ACPI ALS event (%08x)!\n",
 				event);
 		}
@@ -218,7 +218,17 @@ static int acpi_als_add(struct acpi_device *device)
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(dev, indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	return acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
+					       acpi_als_notify, indio_dev);
+}
+
+static void acpi_als_remove(struct acpi_device *device)
+{
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY, acpi_als_notify);
 }
 
 static const struct acpi_device_id acpi_als_device_ids[] = {
@@ -234,7 +244,7 @@ static struct acpi_driver acpi_als_driver = {
 	.ids	= acpi_als_device_ids,
 	.ops = {
 		.add	= acpi_als_add,
-		.notify	= acpi_als_notify,
+		.remove	= acpi_als_remove,
 	},
 };
 
-- 
2.51.0





