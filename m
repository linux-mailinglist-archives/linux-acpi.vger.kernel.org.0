Return-Path: <linux-acpi+bounces-5933-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BBA8CBD9B
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 11:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C781F22EE6
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 09:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DA780BF7;
	Wed, 22 May 2024 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MB0KdTv1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407AA2D047;
	Wed, 22 May 2024 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716369498; cv=none; b=UycrAa0gg+NMFcJ0kWzk7hUSETIYmsgE7f6+cvJ6koVUXcbMAcdJ/wv5x0OuRTA1afRFChrFaszfIKWOP7m7V4wTz32Lc8Ou/TRimuE4MfrZrPySjykzosoFBIq5hLZkr7IgulJBFkG1FmpOtTGBpDt1r0XcM3ZyWkUXD0sR388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716369498; c=relaxed/simple;
	bh=clL0rBh8NOdBwMJgT36ockVwV2WORoYm3aKRiSyAeBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cZW52JGVWH/fB7Vt8pyjlMAPS6FgyIHtrPLk0aqzrI7SJD1CmxcAfmZohY1pwGKVFq/VOjYoKKwP3ekvFO/k84A6B6RZpLtY3G4TTWTGqcDKrK7aNu4vgHPCooIh1+S1ItuUIze19BuqDXM9Dof5kpX2Q/BgK0PyKpq7ZW/X2as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MB0KdTv1; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-572b37afd73so11104853a12.2;
        Wed, 22 May 2024 02:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716369495; x=1716974295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/SuC7+08n2vCECZ9UGktNuVdHeXOcscIV21TQ6r7Hs=;
        b=MB0KdTv1wR7kfJkG2xQ4bj9rNVyWFNs3ud/3RkQqP6+5BnutVNwcFFg5o0lJEJ3Fl/
         PhuLX8RLuFU5OFjx19QajgcAS0/RxiTnzUHeD5uy6XMdIwyqS/DhOdytElAwHl79e6qK
         aSoIPrPeUxxRBmqBwYvz+T6iCxXbbwfx7A+fsnupwq4PotLCeVCIxFk2yX+sOf5VmU1r
         L/U0BkmXHNnoXWXUUbp6/378pNJtID2ZZAG/qOZHpmprcRlLh0fOnJ7GzpqDcErx7tts
         j072mVCheVDqtjRNgSZ6/WGsRIMwD/ewOovFYSTGNHuXZyiMO+9rRZHPP7wIXagD6lcH
         E+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716369495; x=1716974295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/SuC7+08n2vCECZ9UGktNuVdHeXOcscIV21TQ6r7Hs=;
        b=PZtPimNIREhFGIHUhJya2B/97BOUG8R4oE3IwmEbE4eLmqn8RQqfbZ6jaFLsheSTi/
         tjDsNV3Bjh0xtB3+7h193QP/rIS/AxFlO9ifN7RwrW7/3aLSEKLR3yBI963Ka2FjNiXe
         N0R3IZVm4Q5Wlob02a/+HY8uCAP4LvF0qQx2K6vKXFTicvD/7hwqjj2s4dpiHTyyd/my
         4V6g7i+nl0ALG3igrfw3lVB1QGGDiDpueXtUPgCpRIBG8kLR5STXrVdYXvT5ai/oLXhD
         u+FR5fyvTQ5WTNmjrC6bF5nOWLYy4wb3CxpCmySEWMabAI6Vd/qqsPboasiSyyZBSnjx
         8Lyg==
X-Forwarded-Encrypted: i=1; AJvYcCWwQaTjRtkUURIdGTk2WQfNNjjpFXQbiD5C/3a/Hd6n8OWplwxpYj7kpvQjzW/lcR3kDtlripi9/iSO7DBBA/HSwvIPu7wtvyIwsgFwdoa1KEu3o04beXmyZIKCKu6Ji3wCfD/6xLg85Ck=
X-Gm-Message-State: AOJu0YzHa49ZS/N5xIlEJdYjM45u8utZIC2wGwCc6TEmZIbDbC9rQkPu
	1LCV2Im70NaUYSC3xegYclRVPuQIgqHnnEt36YbhhO/H8sQ8Rk2H
X-Google-Smtp-Source: AGHT+IF/abuB+35BiACuJiMAWk3Vdx15AYYVtexypEh5EAJOOiGLT5XZcyn/DsstVdk3MZmt75OvYA==
X-Received: by 2002:a17:906:b2d0:b0:a59:a977:a15b with SMTP id a640c23a62f3a-a6228170ae1mr80912766b.68.1716369495442;
        Wed, 22 May 2024 02:18:15 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5cec3d9b5csm836678066b.16.2024.05.22.02.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 02:18:15 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 22 May 2024 11:18:07 +0200
Subject: [PATCH 1/2] device property: introduce
 fwnode_for_each_available_child_node_scoped()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-fwnode_for_each_available_child_node_scoped-v1-1-1188b0da12dc@gmail.com>
References: <20240522-fwnode_for_each_available_child_node_scoped-v1-0-1188b0da12dc@gmail.com>
In-Reply-To: <20240522-fwnode_for_each_available_child_node_scoped-v1-0-1188b0da12dc@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716369492; l=1290;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=clL0rBh8NOdBwMJgT36ockVwV2WORoYm3aKRiSyAeBM=;
 b=bsLn6S4t9QZoPppi3IVSBbC3zONy3ba3SOgXnySR7A+tL92YLMD5hb+eiqmX3SHgl17fcB6Tg
 gWm7iyGaX0iAKqNnrxExlVt8r8gYWd2doQRuv3C+A7K70zzx4UCFVoO
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Add a scoped version of fwnode_for_each_available_child_node() following
the approach recently taken for other loops that handle child nodes like
for_each_child_of_node_scoped() or device_for_each_child_node_scoped(),
which are based on the __free() auto cleanup handler to remove the need
for fwnode_handle_put() on early loop exits.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 include/linux/property.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 61fc20e5f81f..bcc3dda5a9d8 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -168,6 +168,11 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
 	for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
 	     child = fwnode_get_next_available_child_node(fwnode, child))
 
+#define fwnode_for_each_available_child_node_scoped(fwnode, child)	\
+	for (struct fwnode_handle *child __free(fwnode_handle) =	\
+		fwnode_get_next_available_child_node(fwnode, NULL);	\
+	     child; child = fwnode_get_next_available_child_node(fwnode, child))
+
 struct fwnode_handle *device_get_next_child_node(const struct device *dev,
 						 struct fwnode_handle *child);
 

-- 
2.40.1


