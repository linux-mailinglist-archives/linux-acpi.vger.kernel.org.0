Return-Path: <linux-acpi+bounces-6629-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2C1918356
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 15:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176B8284DF1
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 13:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792931850BE;
	Wed, 26 Jun 2024 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWY+OUFo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC251849DB
	for <linux-acpi@vger.kernel.org>; Wed, 26 Jun 2024 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409865; cv=none; b=E+qSqiRjeEzm2oRQk89qkn4IpD0C1OU33RrAZqERCTlSg3FjCYvGmEr5id01c3j1LPKTwM7OoPgADNNU6Xkm1fzIH2icbOIZvsgPWuUhegdtIJNIC7UVaFhGQNwR7mAgFQd5hvL/Kdnm23Psb/HIQ9ZAOnVrkUbG6NVuXQvs2VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409865; c=relaxed/simple;
	bh=v5AXw9ngrZzxjUnqanBftiFqoJoIIacEF1b+tXN8T1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GM9kpFJMKizxTLEcbZrdl73I97jnm8IFKEFmmnq9fPzTyF3Qwrpc8dYXlo3gvC0KiKKc2CBg3qkGLVlOP+lFUMjNcJjUV4aXLP+YR59AcSkfynNVjpDLW7b9hRVz0gdi7gIbiSqRs2aLt14DpqeJylD33nt4sH8WCqfcDB8t1Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWY+OUFo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fa9ecfb321so2526725ad.0
        for <linux-acpi@vger.kernel.org>; Wed, 26 Jun 2024 06:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719409863; x=1720014663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QOGTEl+2bbGCtMrHBRY0Flc71bTsOam5EB0Z8nUYJEg=;
        b=dWY+OUFo+0nmvNZWOCH7xhIH+kYB7A10Ohenu9ZBTa4+Nl9KGxUtdsHDWjppIAe1x+
         fu67BOvOj+IgGFNOwxs1O/28PtWLCrQnfJ7WPNtcgQl7S/tGEVjxBTXOpj/tl8I9r6KB
         EIK8X1wDD2yaY9uhkXA/t9QkZ4teEoFrgc/pzN6ff854Tveb/R76/3k5O5cs/wnMDOL0
         /hdLH0JyKv1Fakqfdd/8P1bXaYsp9UeKCMuM01D8G2XtwzO0KjRY6UKalFj5+zEnDvsR
         KTh3MQLGY3b2FVznS0UtrWBR5JWUjxX4qksoYYFzPRtFrwr7VYYgwWtDlWpMswNd1pZn
         Gceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409863; x=1720014663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOGTEl+2bbGCtMrHBRY0Flc71bTsOam5EB0Z8nUYJEg=;
        b=KpDensP73luviI5KOg7sovobcLSM0WlJtkPs22SuFUHb1Sf09s+Vtf0CBzlrfT2Dfe
         FxmwAtYwv5MtllA9Gp155VC9/i6bM0GyLSe66CjtsC9uXBsJ90JVaBvgL5zY0l9jqSJT
         RV++qjHXGoOWphnLlS02YZujYTon6YsW6y3Zft9JWWsIBpKbyuAnpHUrdIy/MOuh17/J
         /nns1SbF0rV39rXBLkf5l45OHV6gps1oDglWdATmiKpf5srowZp6sOvN3/9jW6mKX5sF
         540Ro4/F8N7isE+czHq3/bG27R57rW1i2IH63CR01+rP3jvzjN75LNN4tMebF3dgRNTz
         NJrg==
X-Gm-Message-State: AOJu0YzQWm7CtINEoBA29rfkRcLPTz2OLHr8brM9cXh5QtPHW6QQsnRO
	I71zgL8dNqLEmlL1I0k3Cbad/OjFBZ75UyJ1KWqcNupFCxIGJ0wdW/S0WA==
X-Google-Smtp-Source: AGHT+IGn7pMEZKO6Wqpa2Z9s3I/xCcDj2PgiijbI2jdqZVoZCg7ccnjYKXMKIRxbPbY8g9d/5lcg6Q==
X-Received: by 2002:a17:902:f54e:b0:1f8:5a60:842c with SMTP id d9443c01a7336-1fa1d3b6eeemr130012985ad.5.1719409863106;
        Wed, 26 Jun 2024 06:51:03 -0700 (PDT)
Received: from localhost.localdomain.oslab.amer.dell.com ([139.167.223.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f02e3sm99999105ad.62.2024.06.26.06.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:51:02 -0700 (PDT)
From: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
Subject: [PATCH] ACPI: Optimize Namespace List Sorting in nsrepair2.c
Date: Wed, 26 Jun 2024 09:50:54 -0400
Message-ID: <20240626135054.1527935-1-prabhakar.pujeri@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch optimizes the namespace list sorting in acpi_ns_sort_list by 
replacing the direct element swap with the swap() helper function. This 
approach maintains functionality while improving code clarity and 
potentially enhancing performance.

this patch generated using coccinelle.


Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
---
 drivers/acpi/acpica/nsrepair2.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 1bb7b71f07f1..5d56b2fd9151 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -875,7 +875,6 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
 {
 	union acpi_operand_object *obj_desc1;
 	union acpi_operand_object *obj_desc2;
-	union acpi_operand_object *temp_obj;
 	u32 i;
 	u32 j;
 
@@ -891,11 +890,8 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
 			      obj_desc2->integer.value))
 			    || ((sort_direction == ACPI_SORT_DESCENDING)
 				&& (obj_desc1->integer.value <
-				    obj_desc2->integer.value))) {
-				temp_obj = elements[j - 1];
-				elements[j - 1] = elements[j];
-				elements[j] = temp_obj;
-			}
+				    obj_desc2->integer.value)))
+				swap(elements[j - 1], elements[j]);
 		}
 	}
 }
-- 
2.45.2


