Return-Path: <linux-acpi+bounces-10305-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D786E9FC6DA
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Dec 2024 00:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3542C162561
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Dec 2024 23:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825EE155A4D;
	Wed, 25 Dec 2024 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvsvKSfm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B090315B0F2;
	Wed, 25 Dec 2024 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735168197; cv=none; b=PeI8rLbjZiYN0/pvQR0CvTJjqXSiC7oQFqLLGeutN/Fl5nDbOR8Ry8f/DMjwRH4BosbUxnVy7nMFdEhk9NqKottCMHBb5AWsxcg8AkG7vHdEokcpFnGtbIsUDSxs5rzoYoeTeLMD3lQw263LWia0ylUR+fPFaqVgfq2GadC73Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735168197; c=relaxed/simple;
	bh=cXgffOIK+UGqcvAJB+/E8oSILbxrECit01h1rPWtz2U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WyzhQuT1mGrCqOtFzxWDBgHktczGqXqvsrpKPFvSdPUuT7n5GjVkF8SXDPwDSuSyjEsIgK2FOetIHmxPyMoNQCuapMyX9ecxA/ZQaj7Hx5fTDyyRuVM6rk1XGr1nVLWgwgKsoLRxmsRqsNSTFUJdTxIMQZtrLiW/OhYba/qsSac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvsvKSfm; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d27243ba8bso11663686a12.2;
        Wed, 25 Dec 2024 15:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735168194; x=1735772994; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c9v+px78eG66InOEEBnkMK4cXXwgTr2T0JPbH4BNA8E=;
        b=jvsvKSfm0Gndh3IndYjvlczb8+L6c5sWjKC+xM1ihaqxbcB0eEUoBTbgiCiGn3bWFr
         W8hzQhAGhmpQnc51Ax//Gv7bEAzX9YisLG35V1hKRPFlcouuEUsqqve+/xLQ5t++x35O
         gYdPpNm4tIXW0pviD1ap4jCfnFgJb2oqlzF7L08BVLOhD1xYxnKIfFs6mkYBIpuhQeR1
         4Be34LZFEw6QY7yggTcUQB3mZ3Zp8hYUN3LtfiuX6iB+AFGVF9lLM0OtaqcKkk2wGgyB
         VyNQHlFvxwkkJxVWoogEFk7xGo2QosWLFLI4Z+ME4jKfEVkeq9w/v45EddMDjGFUYPR9
         Mj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735168194; x=1735772994;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9v+px78eG66InOEEBnkMK4cXXwgTr2T0JPbH4BNA8E=;
        b=Dlg2+ztt6R5S/wSXbGjr+04CQ9W3j299XcTVXSyelqt6caruNVd8Dri2dvL/FHW8E+
         t5EX7I5DGOtnmfdpl89EqsLhPywYuLMR/EYxAUxnvfS+SS9I1zCA0PLs/PsgTbl0+O4V
         NcRVSyhED7xL1Id5QYajuDa4MHuBi++Q/QxYdIO+Z8DDK66V4u2vyl1dFKAc9h9WcrzO
         8GK9RHg+hd84byhhoaX9lJpeD6GbDNPCRzd0CFoN+5Xj2EU0uMnAXMQapUxW4qAxtZvj
         cjbt3bIEVaOAK280fxDzjuYcmU6Wzbgysf/FPZuPBHxxvQTAATcoxWfNHJAq5BMpCyZq
         5zog==
X-Forwarded-Encrypted: i=1; AJvYcCUBqXFkCTDKQnwo+6lN7nSWRhgrOtXBMW4besUknUH6m38CwmU/RkdiQ9Y3iRBJSJcbp8C33pl2Mt5jD0pL@vger.kernel.org, AJvYcCUwp8n3m0WfAL8ILarcZmHTXsoeAYyEFmGustTyn3Rco90qYeM8R7lOWJgiTNoBrQ7jEnP3Bep/xoQs@vger.kernel.org
X-Gm-Message-State: AOJu0YzOjF40L/5lalv/a7EssZ2CwgCnNtf/r6X/m0XtKWn2nk8wPlCw
	hHoeZMp6wCpmLU5FP+kYG3yqlE6jpCI8bRBm/VZbZjY/JcqZiTBl
X-Gm-Gg: ASbGncsnH3PJpXHFTgd0Ft6nXWk/JjEgssrNLMwGZa/f5BgIAB9mEYok7XIuEFD5qnE
	EZDSjoDptMzc8EhDBtEtw1QGisUg8Uu0bZW7WWyicokJsmphFl0QEmRziGxVMriMRC4HwR9lYIt
	XECKAbT34/zP6Fn28N2JVMJnUbkIN/IsZFYQjBbgjEaiuigPhs7pE5r5BaogmNCmHgYy8YxDdzp
	p6ywXEJzLQw8yKkuAfra+FPquAddMdjeahSKohBWevzDz3WTf4QmBEDZ3LiiWM=
X-Google-Smtp-Source: AGHT+IFmA+25Ix88Cs6aGxcufnGYvRlbbn3zhK/hJN7bbVC8PbiIb0lazhzgSE8YiH5F8BHuqE5i5g==
X-Received: by 2002:a05:6402:50d0:b0:5d1:1f1:a283 with SMTP id 4fb4d7f45d1cf-5d81dd849efmr17082749a12.4.1735168193836;
        Wed, 25 Dec 2024 15:09:53 -0800 (PST)
Received: from debian.local ([31.94.62.22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80678c8dbsm8065745a12.40.2024.12.25.15.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2024 15:09:52 -0800 (PST)
Date: Wed, 25 Dec 2024 23:09:49 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alex.hung@amd.com,
	regressions@lists.linux.dev, tjakobi@math.uni-bielefeld.de,
	rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd: Fix random crashes due to bad kfree
Message-ID: <Z2yQvTyg_MWwrlj3@debian.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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
EDID data in acpi_video_get_edid, and correctly freeing the acpi_buffer.

The only other caller of acpi_video_get_edid is nouveau_acpi_edid:
remove the extraneous kmemdup here as the EDID data is now copied in
acpi_video_get_edid.

Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if available for eDP")
---
 drivers/acpi/acpi_video.c              | 3 ++-
 drivers/gpu/drm/nouveau/nouveau_acpi.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 8274a17872ed..151d1d534264 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1485,7 +1485,8 @@ int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
 		if (!length)
 			continue;
 
-		*edid = buffer->buffer.pointer;
+		*edid = kmemdup(buffer->buffer.pointer, length, GFP_KERNEL);
+		kfree(buffer);
 		return length;
 	}
 
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


