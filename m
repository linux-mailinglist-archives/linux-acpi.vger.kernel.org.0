Return-Path: <linux-acpi+bounces-10532-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B62A0A576
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Jan 2025 19:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B261693B7
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Jan 2025 18:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA241B5823;
	Sat, 11 Jan 2025 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGxGEjK+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDE019F40B;
	Sat, 11 Jan 2025 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736621991; cv=none; b=IANY5PVRzdeTKoFpMf5sEJWSrdX7Nz+98rVFr9CcRp5fxOfUbIv74YIt5KDBziVeNtuRcXW0SjX1rlKeTgZqH1GyuRa3cvEej0j9Mc35qpi1dwVaNB/E9zh8RXznSxmfc8BKvAS2QsnTIS26gQLhM8XmDkWPMFscDi1E3QVvMuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736621991; c=relaxed/simple;
	bh=oX5yPNdl+nQlEHEz0LVIlKvTWgYDyu44Yx/Y3chKZus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEeA4HLJikWFUZqLXI2uFL0Qb7J+deGnIAEabr4+u2QNh9AcODtn3kw5YkHwqBfYBYcoNwYvrLnpY6NYTc39wZFeZIjI80fl84/Ynf0bZ9QfsGvJTHdeCi0ny2e5JKKgjA2Y4SXyFNrhNrUVDYiunjK6XpB0sCVQr1Bh+UV0CBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGxGEjK+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436637e8c8dso32994435e9.1;
        Sat, 11 Jan 2025 10:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736621988; x=1737226788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L3DgohbenACHXn6wOW4eU9gM7Gu7Z7kDdY29V2QFR8Y=;
        b=QGxGEjK+HN/m0DgxOQ0eYBCkTCKdQgsWt4R7l8uowhctGmj0+UVbvgsM+1TBIm42kT
         QFhf6rXKOGfM4lFQtTmnCo4+LM7PfUXYYd0OfB9fCbllQdLd54FptPfK00rG5WSuaAZj
         +Up1hQe9DoZ6akSQzCOKM+SQKwUassU1W3A608hVdcdStQddOCskUuBlv0lGNu8mInza
         oh9s3LIy2OOAa30WxRhjWgUrImCx+JCZBrwpN6/sdYXG7/TUUGzESK4tahdav3uVZGvY
         OG8MtG0ECYhfELBQmri/f+m649UW0rLOXrIiZnEajf97Hp9Lu+IY9eABo3MxEcLdppyW
         LQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736621988; x=1737226788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3DgohbenACHXn6wOW4eU9gM7Gu7Z7kDdY29V2QFR8Y=;
        b=bU4NoFm+Agn9+97XikTNyPIX5eK8puvB2B9IxxDaYyrWofZeJAiyHujYS702WMSf61
         5jU982BEFNn0Ncwy5jHIKrWmLjz3LzGmqchzb6JFdoKOxuCqvPfMzpo47oaciMRtYG6J
         N+pglGDc9DD9ikESl9ZPDYMddWhCp6zSh8vIv4xcslY7yAxEw8n7eum+D3DYvOuqbxsj
         gtxfdOpF2HtysWPtkA7d0aOib2t0yD6Sx+GvLTNX4L1FDnpp8iJpEZvY3xNGn8GXVmOc
         qP9xgUJeTZUYx0W4/mVw3KW9bmARYwIBGin8KBmGsUKoubwAkwakF0hTaA4r3WmSveAo
         /Upw==
X-Forwarded-Encrypted: i=1; AJvYcCURcLgNDaTTYee5bReY+6EGind06SQxsw16JPPgmBt+MyRH78noH0Ex+W572GfPjOBKlSQipYqV3OvtUAHL@vger.kernel.org, AJvYcCUZiEgCfYFFbJFiPoWZNHnUtYt0iiB9+CIUOVV/549pdnABUHwAM5SR4nJ/1G/FdOF0ZLMr6AMypeev@vger.kernel.org
X-Gm-Message-State: AOJu0YyXOIvRLyfupRX1nh6fRtnS98IdKOyld19WfJ4WhYDNmNeXKmgp
	FKaTVEw8jlDW+hQECcDOnxwndBPHNO40e2pMBZiiDfv3MCFypRDf
X-Gm-Gg: ASbGncvUJmI3JfeZA43590p/kUpl6XXRqmL9BfdcFfRY/OkEs5v15HPMWoc4eAvDS87
	DpUABQoffFuPgh2u6VJSnVlSj4i3A0Ycds8F67ebvluKl99mvo5NbCdJVe7I2kqY7lGIN1CRUYb
	3LxICUrinEIdixDvR4q3uzd3cAZoG4DlQYi0PNeci2/PJdYGaqmj9ngSEMy/o6vA0qzrmbK4yHl
	63QnxOHW1z9npBxPn17ssyhcCKwhkq9fl/3YcPcg0PrW1A6dtmW8SGOhFYRVZV0iw==
X-Google-Smtp-Source: AGHT+IEPA1ZIEy2BVvJIreSvtc7pK5EpKKeAI+bCNXKQkeEEBtMKu5+tlqaQ1Ywp2IM9xt0CHUsflQ==
X-Received: by 2002:a05:600c:348c:b0:436:ed33:1535 with SMTP id 5b1f17b1804b1-436ed3316a4mr93947005e9.12.1736621987670;
        Sat, 11 Jan 2025 10:59:47 -0800 (PST)
Received: from debian.local ([83.105.230.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e6263fsm92372725e9.39.2025.01.11.10.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 10:59:47 -0800 (PST)
Date: Sat, 11 Jan 2025 18:59:45 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	amd-gfx@lists.freedesktop.org, alex.hung@amd.com,
	regressions@lists.linux.dev, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] ACPI: video: Fix random crashes due to bad kfree
Message-ID: <Z4K_oQL7eA9Owkbs@debian.local>
References: <Z2yQvTyg_MWwrlj3@debian.local>
 <b98f2fa5-fbe8-4958-bf20-fa5d28c5a38b@math.uni-bielefeld.de>
 <Z2yw_eJwR5ih1Npr@debian.local>
 <CAJZ5v0i=ap+w4QZ8f2DsaHY6D=XUEuSNjyQ-2_=DGOLfZjdn+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i=ap+w4QZ8f2DsaHY6D=XUEuSNjyQ-2_=DGOLfZjdn+w@mail.gmail.com>

Commit c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if
available for eDP") added function dm_helpers_probe_acpi_edid, which
fetches the EDID from the BIOS by calling acpi_video_get_edid.
acpi_video_get_edid returns a pointer to the EDID, but this pointer does
not originate from kmalloc - it is actually the internal "pointer" field
from an acpi_buffer struct (which did come from kmalloc).
dm_helpers_probe_acpi_edid then attempts to kfree the EDID pointer,
resulting in memory corruption which leads to random, intermittent
crashes (e.g. 4% of boots will fail with some Oops).

Fix this by allocating a new array (which can be safely freed) for the
EDID data, and correctly freeing the acpi_buffer pointer.

The only other caller of acpi_video_get_edid is nouveau_acpi_edid:
remove the extraneous kmemdup here as the EDID data is now copied in
acpi_video_device_EDID.

Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if available for eDP")
---
Changes in v2:
	- check kmemdup() return value
	- move buffer management into acpi_video_device_EDID()
	- return actual length value of buffer
---
 drivers/acpi/acpi_video.c              | 50 ++++++++++++++------------
 drivers/gpu/drm/nouveau/nouveau_acpi.c |  2 +-
 2 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 8274a17872ed..3c627bdf2d1b 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -610,16 +610,29 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 	return 0;
 }
 
+/*
+ *  Arg:
+ *	device	: video output device (LCD, CRT, ..)
+ *	edid    : address for returned EDID pointer
+ *	length  : _DDC length to request (must be a multiple of 128)
+ *
+ *  Return Value:
+ *	Length of EDID (positive value) or error (negative value)
+ *
+ *  Get EDID from ACPI _DDC. On success, a pointer to the EDID data is written
+ *  to the edid address, and the length of the EDID is returned. The caller is
+ *  responsible for freeing the edid pointer.
+ */
+
 static int
-acpi_video_device_EDID(struct acpi_video_device *device,
-		       union acpi_object **edid, int length)
+acpi_video_device_EDID(struct acpi_video_device *device, void **edid, int length)
 {
-	int status;
+	acpi_status status;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *obj;
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
 	struct acpi_object_list args = { 1, &arg0 };
-
+	int ret;
 
 	*edid = NULL;
 
@@ -636,16 +649,17 @@ acpi_video_device_EDID(struct acpi_video_device *device,
 
 	obj = buffer.pointer;
 
-	if (obj && obj->type == ACPI_TYPE_BUFFER)
-		*edid = obj;
-	else {
+	if (obj && obj->type == ACPI_TYPE_BUFFER) {
+		*edid = kmemdup(obj->buffer.pointer, obj->buffer.length, GFP_KERNEL);
+		ret = *edid ? obj->buffer.length : -ENOMEM;
+	} else {
 		acpi_handle_debug(device->dev->handle,
 				 "Invalid _DDC data for length %d\n", length);
-		status = -EFAULT;
-		kfree(obj);
+		ret = -EFAULT;
 	}
 
-	return status;
+	kfree(obj);
+	return ret;
 }
 
 /* bus */
@@ -1435,9 +1449,7 @@ int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
 {
 	struct acpi_video_bus *video;
 	struct acpi_video_device *video_device;
-	union acpi_object *buffer = NULL;
-	acpi_status status;
-	int i, length;
+	int i, length, ret;
 
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
@@ -1477,16 +1489,10 @@ int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
 		}
 
 		for (length = 512; length > 0; length -= 128) {
-			status = acpi_video_device_EDID(video_device, &buffer,
-							length);
-			if (ACPI_SUCCESS(status))
-				break;
+			ret = acpi_video_device_EDID(video_device, edid, length);
+			if (ret > 0)
+				return ret;
 		}
-		if (!length)
-			continue;
-
-		*edid = buffer->buffer.pointer;
-		return length;
 	}
 
 	return -ENODEV;
diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
index 8f0c69aad248..21b56cc7605c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
+++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
@@ -384,7 +384,7 @@ nouveau_acpi_edid(struct drm_device *dev, struct drm_connector *connector)
 	if (ret < 0)
 		return NULL;
 
-	return kmemdup(edid, EDID_LENGTH, GFP_KERNEL);
+	return edid;
 }
 
 bool nouveau_acpi_video_backlight_use_native(void)
-- 
2.39.5


