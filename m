Return-Path: <linux-acpi+bounces-5968-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E298CD796
	for <lists+linux-acpi@lfdr.de>; Thu, 23 May 2024 17:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA54728242C
	for <lists+linux-acpi@lfdr.de>; Thu, 23 May 2024 15:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9F81862A;
	Thu, 23 May 2024 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hk0akTly"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51317171A5;
	Thu, 23 May 2024 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479257; cv=none; b=GfBnvdJarzNZOqYF2cInTgOYHVGwDcy7MMYTmWrp1M3DGr0BrLr+poX9WP4oKDDLhAYt/gcF3lf01NClhjp8Y5g9I3fyvgk4e7moP5Yigr9n4D0grKyzbhqWjlLoasyPBIuaz0SlYkTrfdGaNwLfiWd2olSGD24kA1NcX6rK4cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479257; c=relaxed/simple;
	bh=mgKxk4kqyOKEtZOpwFvK75hdFyTZlYf7QqUN84i837Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZHUGxwjPgjfxt6rJ+6lkrAKibiu0yrFGl+Go/ZZXCze5VUpu0PCHZjAif4ai+saVxlc0oNF39NbifiUkEFdXkAspTGWw+nUg5X+lBXXPmS+f2BdUGqit691A9rHuwkAUDjGqRA4n4A9CG7cAPv6ciG8UR1WgcU/g/JL8CI6pa4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hk0akTly; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-354f69934feso670077f8f.0;
        Thu, 23 May 2024 08:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716479254; x=1717084054; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ni+RqltCXaCNZL9b8F9XE81/Sw38rziGN7U8OpBwI5k=;
        b=hk0akTly3q6jR1Lsot6+DIEM4mufldbnnqx4AyNBPee0hBaK1pgpc1Dj0rkN1V6Krz
         km+dZHF8okcunrhiEqNsW0PINNAAwih7y0xzx76H3AZ9/qcxAsMQUUArsrezyBpGGRFZ
         FLN6u9VfoAXCmFM4tJBNaXqI60NYG4nMvQBEMe+n5Fb0etyPqy5cWozzO9hESQe2vAp2
         Ljv7pnq/zQb+R98xHQtZAhfzPSaiwinwIoA5NWbNZ5QERIt1TuOl5lhG6sNAyACfZMqs
         4NtkaAChViF+tHJa4g7Vl2ypsDj+Gqk3UvlxidHIXetLRoCtVjLgImY4acz7XIr6MB1E
         ReFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716479254; x=1717084054;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ni+RqltCXaCNZL9b8F9XE81/Sw38rziGN7U8OpBwI5k=;
        b=Nemusx2l6LgU27rgGFJXVrZqsGVImTjGOhaAxXKMJsoV2PlFejOTGN4kWtMCZGw79y
         uWCSfjWO+YzCDg3oRB/MgbPp0HPMg0m2V4FabUQssdlyPH5vwOlwIecv8oFikkahFg3M
         ZsXnF5mFQLSubIYtzi9q7o/LhKwIEvHn0ctiSo2sbqb+hR44bOVLZQp0AjDewt3CvWrg
         KSJsq5e2MCMRvtVOTn8i56noEUgkUebG64YtdW4dOKge9Ixbqpri343ZqiaJ8395Ufn4
         xzaJAacjSircC/xt9Nb5MGB9qnnIkbfTbfdKEqwaTbTrG1WMydoTrXLEzSvrTKKZaCpU
         puNw==
X-Forwarded-Encrypted: i=1; AJvYcCVy9zCLwW3cyfTntn54qi7+lYb4Rt0kWzAhPPNOBxcfSm16RmQ0whF8W7Zls+l4qphD3zV2m90TLFeQGy1PSkoiu5yVfM7j/kYDfckRr6nX1Yq4injESQWdnz0G3xFXK8VyeeVoB3aESx4=
X-Gm-Message-State: AOJu0YyPDjpR37hmU0qrcsNb0dJAGbX+0SmH+/WImOg+FtODryjL//GN
	X41v5wOcBRlCOFyEUhNyDqq4VvxbP9My+cAo3A99K+XKIqGUSWF8P6myBVmlkhk=
X-Google-Smtp-Source: AGHT+IEwdwLQgejvo83vwsUa0ZCY0Of9z20Fn1QFyxSqI+jRPjwvqYvdzzAxg8fiUD/VeoWcasAvzw==
X-Received: by 2002:a5d:6351:0:b0:351:d9a1:4f1 with SMTP id ffacd0b85a97d-354f75a3d6amr2158769f8f.32.1716479253982;
        Thu, 23 May 2024 08:47:33 -0700 (PDT)
Received: from [127.0.1.1] (84-115-212-250.cable.dynamic.surfer.at. [84.115.212.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f5a576sm28569725e9.22.2024.05.23.08.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:47:33 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 23 May 2024 17:47:15 +0200
Subject: [PATCH v2 2/3] device property: introduce
 fwnode_for_each_available_child_node_scoped()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240523-fwnode_for_each_available_child_node_scoped-v2-2-701f3a03f2fb@gmail.com>
References: <20240523-fwnode_for_each_available_child_node_scoped-v2-0-701f3a03f2fb@gmail.com>
In-Reply-To: <20240523-fwnode_for_each_available_child_node_scoped-v2-0-701f3a03f2fb@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716479248; l=1414;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=mgKxk4kqyOKEtZOpwFvK75hdFyTZlYf7QqUN84i837Q=;
 b=cWDs4kp+IgTdKqY6DfDtSL7FHqR3iOb2KbTMby/6acFeycZrT4oYGqPhHUdw9dpl9CGxOetju
 XyFHz93zxa0BOGPfwNzOPf/S862rlPjTobwnUxIwQ7+UbPNF+Z+3G/u
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Add a scoped version of fwnode_for_each_available_child_node() following
the approach recently taken for other loops that handle child nodes like
for_each_child_of_node_scoped() or device_for_each_child_node_scoped(),
which are based on the __free() auto cleanup handler to remove the need
for fwnode_handle_put() on early loop exits.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
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


