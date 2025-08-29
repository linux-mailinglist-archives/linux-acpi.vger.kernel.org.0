Return-Path: <linux-acpi+bounces-16164-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FBCB3B0CE
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 04:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447D01C26AC5
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 02:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C2E28695;
	Fri, 29 Aug 2025 02:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtlLd1JH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DC6189;
	Fri, 29 Aug 2025 02:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756433887; cv=none; b=mej3RUO7Am04ysU/CjG6o0kjk7d6MAI83XUCvWOp2zMCI12GAA/WmnuDgLs7IclxKKHhLflK+nf/23QRwX+ej0+14JxckglHvv4j9WMBRNZG1jh4NmVDoRpa18h/ZnT6yZrOCBrwZy+0FKB4tswuolML6+f216PeohwzNzGx5DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756433887; c=relaxed/simple;
	bh=rhOcQf4lmzOvndYWzv+wjmRQPKHdQrN1F/gy4wvnhx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G1CgwDuUs2/5vNluRtj4Nyd1+VFyArCm8mY+ZaQkIu3ymsbNQAAetApO7mwyjcE5+wH19jMyyucf48RO2Ws/e6XVMBV26oQ3X+wTe5bHJhSfxYQ9zRw00Ti0pfUyyh738pzewaK8EaWF4hQ1/lY15XuMghotqp8J9pYrWnN5EaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtlLd1JH; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b2cf656e4fso15313471cf.0;
        Thu, 28 Aug 2025 19:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756433885; x=1757038685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dmi5nto3yi3lP2KtXIHpoZiHzjJ5dpWYmN7F9HWG7C8=;
        b=QtlLd1JHiKYYwag0mDOBe8KUXo7quJ4OQq5r+22RA1v6OzAIok31yinguRQ/v0CSRq
         pSiChw9w/qclJMRjY9lKPKs9VaDZLlsaPx1uIRoRrXhV+nYQ89RasYIBGSrabaotVUlW
         bpAsdv848XQp425igYTOOptcmACb2lr3RE6Y6HMbB7S0OgrA5TO5wMxSYueLBlLacfqf
         URR+1J7kGyZvPco7J1SeFP8gqsOJNoS4ZF2YfOUhF/m3cpBSjusnnIAoR1UdRIiE+8Pr
         5b8LYOiSPCRxXDgHQR1hMpMcfa/qnTzT+HymzDqWsHu7Eu/b0rppoFFl1i+yThLveVuv
         tMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756433885; x=1757038685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dmi5nto3yi3lP2KtXIHpoZiHzjJ5dpWYmN7F9HWG7C8=;
        b=BQenuCwiznVr+oi8VKEd4RkC86NHGLsttO9yDpDrkBxJGCpJvHAh/dmvudVi89D9L8
         teyNCqqwr6iwNxv4OjG9rfOAXT5613EBJ4q8pcG5pfh/94POg73vAhnINgeHbmsy/V6T
         D1HS536MsXXcriIoxy96b6UCc7ngSDb+25+tg7AsXs8NU/W1Q5HPCiD+uFgDc3Pt+Xon
         4ehEJlAIpKiw1fMLdLTmBd5U9yBcZxTrcnKrqSP1q8fN5budZGeBuEj+tVCED0tZb4mj
         B1CTwY+T5ds8iRK5Xnlc0aQf/5xK2wUpwwF3FCk/Ro9xCdo1AFreAHfchQn2Cdb9Ewp7
         1PRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeJkDdZfGZ7iRTOHu+/hVpY5J3Scn7C6C5Dp1pcoNZ7LlLgdjjwvZCp6K75yVOYS8+f7VfMlw5vFrsZ7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg57b47mzGmcWfnoOZFMice1xAeGdQsm8d+aRlF1heLHsDXuIg
	K+Z6loIj9LiBLV9djnWDvgoSStByyHwEt3Q9OD3ar4IFY21P/t+xXq7vUVgmS5Dh
X-Gm-Gg: ASbGncu3mhO76cbKGLNz0BBZkzBGph02FSngdNq8ZEzPxvCfu5k3z6fQEqjJWz+MNrg
	X4vuIwJ5mkwWZzl1gX6podk621MxnTUVkaGa7roWbwHPTKJ99E9jJumMOGfYi6jrWIhPmgkTLF6
	u0Ut0GFLNV6WIOLrQ73uiIjyqtL2rpMXBynwYXYKpirbxEz4htXHjNxGN0I9MVteL7s9WMsIlVa
	CXqAmFZTndqmkiq3I6gsT/ij2OdMqsP4DblQLALHBG+GVy5ezw+4B/cbfaOLJzHm7ujdajqlY6Y
	tc4+n42c/NHoA/m5eamM0+qObSkJSFayJme3Ui9jUR9LSO1ZEBGIu22uqTAPZ36Fo5wziArNECt
	G2LP1k01Szvo2Mw1vPBNmsSYY/BLVugStjn8OjRNYmjHy9NJ4ZajIzY+Dwybbkd/Ch1b5nW3z0K
	sFVOU=
X-Google-Smtp-Source: AGHT+IEttyxERBZucuUJv2VBL1kbTEcilFln7lKkGvkx8cRUAmICN4qJFm9OjlYFJWQo7EKy6IJT1A==
X-Received: by 2002:a05:622a:4816:b0:4b2:919d:f37c with SMTP id d75a77b69052e-4b2e76f6ae6mr177445791cf.38.1756433885187;
        Thu, 28 Aug 2025 19:18:05 -0700 (PDT)
Received: from localhost (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b53732dsm8573781cf.10.2025.08.28.19.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 19:18:03 -0700 (PDT)
From: =?UTF-8?q?Jean-Fran=C3=A7ois=20Lessard?= <jefflessard3@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] device property: Add scoped fwnode child node iterators
Date: Thu, 28 Aug 2025 22:17:59 -0400
Message-ID: <20250829021802.16241-1-jefflessard3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add scoped versions of fwnode child node iterators that automatically
handle reference counting cleanup using the __free() attribute:

- fwnode_for_each_child_node_scoped()
- fwnode_for_each_named_child_node_scoped()
- fwnode_for_each_available_child_node_scoped()

These macros follow the same pattern as existing scoped iterators in the
kernel, ensuring fwnode references are automatically released when the
iterator variable goes out of scope. This prevents resource leaks and
eliminates the need for manual cleanup in error paths.

The implementation mirrors the non-scoped variants but uses
__free(fwnode_handle) for automatic resource management, providing a safer
and more convenient interface for drivers iterating over firmware node
children.

Signed-off-by: Jean-François Lessard <jefflessard3@gmail.com>
---

Notes:
    checkpatch reports false positives that are intentionally ignored:
    COMPLEX_MACRO, MACRO_ARG_REUSE, MACRO_ARG_PRECEDENCE
    This is a standard iterator pattern following kernel conventions.

 include/linux/property.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 82f0cb3ab..279c244db 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -176,6 +176,20 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
 	for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
 	     child = fwnode_get_next_available_child_node(fwnode, child))
 
+#define fwnode_for_each_child_node_scoped(fwnode, child)		\
+	for (struct fwnode_handle *child __free(fwnode_handle) =	\
+		fwnode_get_next_child_node(fwnode, NULL);		\
+	     child; child = fwnode_get_next_child_node(fwnode, child))
+
+#define fwnode_for_each_named_child_node_scoped(fwnode, child, name)	\
+	fwnode_for_each_child_node_scoped(fwnode, child)		\
+		for_each_if(fwnode_name_eq(child, name))
+
+#define fwnode_for_each_available_child_node_scoped(fwnode, child)	\
+	for (struct fwnode_handle *child __free(fwnode_handle) =	\
+		fwnode_get_next_available_child_node(fwnode, NULL);	\
+	     child; child = fwnode_get_next_available_child_node(fwnode, child))
+
 struct fwnode_handle *device_get_next_child_node(const struct device *dev,
 						 struct fwnode_handle *child);
 
-- 
2.43.0


