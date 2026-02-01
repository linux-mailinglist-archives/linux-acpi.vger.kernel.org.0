Return-Path: <linux-acpi+bounces-20806-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKnMAbCYf2n3uAIAu9opvQ
	(envelope-from <linux-acpi+bounces-20806-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Feb 2026 19:17:20 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF708C6E13
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Feb 2026 19:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7473F30062FE
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Feb 2026 18:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ECE27FD51;
	Sun,  1 Feb 2026 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCduGZVx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C693EBF3D
	for <linux-acpi@vger.kernel.org>; Sun,  1 Feb 2026 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769969830; cv=none; b=EMe5P7piKsAs6qldCy1Dl3fGIeLGpvjrDloJmSs6baSqyMWCGH+P6PKlCMsTi9yPlF/PDDLkGgjOEbcSeiwBaxacRJ5MXC8FVLANbe7RqJMlyKbIS0RMtnwAhvBJ5AKhH+c20DEJ2IBt4jXwPjaLn903MBo1HpqPx2MQ7YDApnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769969830; c=relaxed/simple;
	bh=GUrSB2n7oRGHcPWkgJseQFjjXQatFD2FzE1j1iw6aYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ip+fAeqYGWlL0GpBY7e6lMqS/0ZE71I53mDIZ7sJR+uHeWNBMAOTYTW1fICTw+upiBght6svBIvvhB/XJ7zMEbYNOU5KbJ6hH2kTo338kxr0qw31tMnlcAqSjHShDRDKHwHkafpqiJ4gr15SpZwZmfN5dflZJ6xLp6+KM9oMS3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCduGZVx; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so3207587a91.3
        for <linux-acpi@vger.kernel.org>; Sun, 01 Feb 2026 10:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769969827; x=1770574627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ujk5k65rRpax7qPZizdIUInwgoyZVajK00HSdGaFW4A=;
        b=jCduGZVxIkW4NcfG4AgGYnKp/jAFY2qXs60z05koxHd+ij7FqJ+V4Xw5Dt7vQasHPH
         OicIOCjXA8fz2bYAX3cWNAIgg83Jh1k1xybwq7OlzuXkkPK5x+qYrQUndnx8ubqjF11q
         kQke8sYxsJbJD2hoKBquMLyy+Wu+VJEj//5ujx4WyWrfNUcVtdaODHrAAYKUnGcK+qBu
         X29fIg3gVksGRprxnirU3DWC2dxbSSrraA50uqIUwG8OBW6Rg5Go6gxJy0yfoJmMfV3g
         bg7mJe+gcf9meT0X4B+s8vz/P2ZZa7AW8yysNJRtRKERHbLRATP5WSNFRljt/9W6KULG
         +pbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769969827; x=1770574627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujk5k65rRpax7qPZizdIUInwgoyZVajK00HSdGaFW4A=;
        b=w8rVeqVwX3uFVt2BGATWRhEfnbU8CNwMqkyp+S+i1rdacxiX4xiIWSqIEZ8Gc6+Of6
         dxxgLXp7Y5cfDlQarvTp4+Pcl3X2FCkUANa3rIeC6ao9jYASwVFksqErUZyFxW3GDDA3
         jXWsRXfJXoT5pwKiI8+jv04CTWix7uh7YDblv1KlzoH5kODIGgsVCJMPn07OOAmwYlYG
         R72cmeycpLkyXlq7H4VZwPTZx5CtQPUUypX7CU3CO7aP5Ex+Z2q8DS/lgSB6Gsc89K36
         2WJ2Y2p+/Sq2jDGRlr3l3IseIbLWB6iYzum2u7qbdvX2JDOTNDtgxEYYjtLzmLJ4JGBL
         6YdA==
X-Forwarded-Encrypted: i=1; AJvYcCUCFw+J1jlRZFAalUrjYf9MeQwzcpthnE+iFH8LGx6FIg8y+3TiUFysxmEk7lZlBLo31r4K8fnx/YdI@vger.kernel.org
X-Gm-Message-State: AOJu0YxUV7zyvzXPQUXCRHEM8Vy2JWLuPRaA+EOR4m0Eld9YCEr7W3hR
	njNuxuDavfwAVTabnojtC2OE+IttmZDoCTMZG/4ScaafR3D7a5tUAppN
X-Gm-Gg: AZuq6aIJo4zkgfLwYZMkEJWX6/oNmG1E22x9aOzBtSt+etnzAT/Ergxro9OK+BXtOQJ
	+sCMKXQLq4ia5JuZJDra71cApFU1kY1qtU0zGtYc8y4vr+KHxTMNlGtBdi0FuWy+f1VU9HebCZf
	843DmkwQiorZGq6hj3PLJbI+f6ytEP0FB7lr5zZFrYT4zprJuhJanxtihk/m6KeDzYgaHioWOW8
	BAcu6MYn37KthAyMAy7+svpAx84EYovWLpxk1rUYTIPmWvdiy4Izy+961piQD2CYD2KUmf/nEUy
	boEzcDTw3z0qbt0vlxLL2FzEUPoIIhIau8+SY/YCEA2sm3iEK42lvo3m1agXnI9rgmvG0Np+j5C
	Bn6v22zAOzxbdyQ3fon7r4/kbWBLqlE+E725Sy3/CT1kR+hWyFdtYBzcren+mpfSQS8XqeXm7gJ
	svvQBCehD68yLANNU+
X-Received: by 2002:a17:90b:3ccd:b0:352:bd7c:ddbd with SMTP id 98e67ed59e1d1-3543b38af32mr9508501a91.23.1769969826957;
        Sun, 01 Feb 2026 10:17:06 -0800 (PST)
Received: from gmail.com ([2409:4081:2d1d:b4be:89d5:e086:c91c:ec66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3543bab8025sm3192608a91.0.2026.02.01.10.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 10:17:06 -0800 (PST)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	robert.moore@intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] tools/power/acpi: Replace strcpy/strcat with snprintf in osunixdir.c
Date: Sun,  1 Feb 2026 23:46:20 +0530
Message-ID: <20260201181620.4964-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-20806-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumeet4linux@gmail.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF708C6E13
X-Rspamd-Action: no action

Replace unsafe strcpy() and strcat() calls with snprintf() in
osunixdir.c to prevent potential buffer overflow vulnerabilities
when constructing file paths.

The snprintf() function performs automatic bounds checking to ensure
the destination buffer is not overflowed.

No functional change.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 .../power/acpi/os_specific/service_layers/osunixdir.c  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/power/acpi/os_specific/service_layers/osunixdir.c b/tools/power/acpi/os_specific/service_layers/osunixdir.c
index b9bb83116549..5dc960c6b376 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixdir.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixdir.c
@@ -113,9 +113,8 @@ char *acpi_os_get_next_filename(void *dir_handle)
 				return (NULL);
 			}
 
-			strcpy(temp_str, external_info->dir_pathname);
-			strcat(temp_str, "/");
-			strcat(temp_str, dir_entry->d_name);
+			snprintf(temp_str, str_len, "%s/%s",
+				 external_info->dir_pathname, dir_entry->d_name);
 
 			err = stat(temp_str, &temp_stat);
 			if (err == -1) {
@@ -137,8 +136,9 @@ char *acpi_os_get_next_filename(void *dir_handle)
 
 				/* copy to a temp buffer because dir_entry struct is on the stack */
 
-				strcpy(external_info->temp_buffer,
-				       dir_entry->d_name);
+				snprintf(external_info->temp_buffer,
+					 sizeof(external_info->temp_buffer),
+					 "%s", dir_entry->d_name);
 				return (external_info->temp_buffer);
 			}
 		}
-- 
2.43.0


