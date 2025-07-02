Return-Path: <linux-acpi+bounces-14944-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96902AF5D66
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 17:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B094E711E
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 15:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4112D77FC;
	Wed,  2 Jul 2025 15:40:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4A02D375A;
	Wed,  2 Jul 2025 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470816; cv=none; b=KjrrsivPKiQCsECUi0lnnxmFrIHjTpVnGwItTcTwSIDYLwk1ABFdoZFt3NhYFfASkHrHkA4xKX0G0nkPoyLrEzDpM1fpgxdmNZU4or6oZoSPpSOiDaESlDtoq8VSyFv3WdIeDopzCR1qFyRoyEpco2EvFxpAQuuHEYvYI4n58jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470816; c=relaxed/simple;
	bh=H0p2C5Aq/L5bJMThl0O5sb0mwWXsUG5t59ilBo5jr9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gnXmtvQ+n0N9/u9XceSZ1VE4UVNkVLYmfUbRCiTjslhOb0L9yN/mDpeeuuq0Vax+4Yjo+04JT+zohn43qMkujliAODJLV15ObSBjZnII07sQOZ0HPCejZy8F/TJ9cF/VbP5rJLh7IBlz8JE3c0fDQSUszhfN6RSzVKTa2EY1f2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-acb5ec407b1so820866666b.1;
        Wed, 02 Jul 2025 08:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751470813; x=1752075613;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7FCXzq9xPVJKybdTLnzGouu8qhNq09dAOCfBWEVvIpQ=;
        b=QG/VT7xJIc8NzcdpI+4XBv+XNnE/flxnLPnQxI2fgLpdcLjvBT9KvwDiwyTfJvLEoK
         rF2raA0OoxAdlOqOMiFgMYE5GzQLNqDn6uDfiQQG1KFyJRDTGKaYZ1avny3zOc6RVuKi
         edMDXN9JuU3GxtpTF07I1gXwNNOdUHFVINZfqzmNQ9BpeozMh1EqnqlOeh9oeviWQNu/
         hbXTgBJVGPZgTlGTDOK9KP+MmHG7nsuBz8B6fBPB0HhgZ1ehzrjdy357PjcAm+z5iVrU
         jtOckMxl4TAbrIQ133o0LrhEX0cr1ejq/YouwJWaFHtvA/kNcfBxjOIOLjR/R9NxrrnQ
         yQTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb+AQov+M60lzZqCobtWrEnIfj9+7+I0YGXMJ7heL+l2jwbCQb8zTz/Glyzej/tiNt3z6tbcLKgtNrfno=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIq4e3UImWzHRkqCVmJWo/rvh1iX2bpVp/+1c9Fhv2Du81ukOp
	Jo+JAWUqD5NLDvexNMeyAQASowfHfxdkKw8sj6EwoZ8hzrwYo7yISlY+
X-Gm-Gg: ASbGncvRFHigntwAyHILbIOx0FCoeFeQP/krKqE/hakagIOmEvmrQC0E9xyBFq8nNvp
	yDoXwB5w4BIGjj/G4UdPsjVRUgeJw/RMGYg+VIP/UfANx+1eGB2fmmXXgB6Sm2saLGmlsTh4fAR
	jsocGec/DxG7rhGNJ4Kbl9uUBNEq9UcXP/WW8WIa9HqZSUjbQYHl9wwF+N0BEYPJcPGvSMjpiGJ
	Z8dq6y+JJALsbO4f1Z7z0dwP7kW1BOnwMzIpT5OxDwsjpA7YaghxgQJkdx0hgJ88d2lBcZKnOHn
	+ue1+1QBH815rjeUx2FmFtwVlh4nFD7tdNaBAiv42fYlNCTFjNwE
X-Google-Smtp-Source: AGHT+IFhKD+UFn3R+yw3qSulyUTwOClAqgA3NAxQ1uOk0f4fjkjzQHBjYGokXqp5b5GBQRaEIwd4Yg==
X-Received: by 2002:a17:907:9719:b0:ae3:6eb9:60d0 with SMTP id a640c23a62f3a-ae3c2da637amr364942766b.42.1751470812395;
        Wed, 02 Jul 2025 08:40:12 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6b407sm1099063666b.117.2025.07.02.08.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 08:40:12 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 02 Jul 2025 08:39:51 -0700
Subject: [PATCH] acpi/ghes: add TAINT_MACHINE_CHECK on GHES panic path
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-add_tain-v1-1-9187b10914b9@debian.org>
X-B4-Tracking: v=1; b=H4sIAMdSZWgC/x3MUQoCIRAG4KsM/7PCNOGGXiUibB23ebHQWALZu
 wd9B/gmhnbTgUQTXXcb9mpIdHKE9Znbpt4KEkFYAl9YfC7l/snWfGSJEupZH3GBI7y7Vvv+q+v
 tOH4Zn53XWgAAAA==
X-Change-ID: 20250702-add_tain-902925f3eb96
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=leitao@debian.org;
 h=from:subject:message-id; bh=H0p2C5Aq/L5bJMThl0O5sb0mwWXsUG5t59ilBo5jr9k=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoZVLblba1mllPYaf1aVPQXI+4DLke3A7+VQT36
 l8gsOrXjieJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGVS2wAKCRA1o5Of/Hh3
 bXLCEACiRSNk8lLaC0DKhfgWK8qrihxDqBJEExogxZV4kRPUhf/iya8+NK83C/pN6NqV0zgbcTD
 eRdm+5eD78zTVi1M8PzR/kn3mDhpB2MKDYPtk11zsXi8vjrpPLl5H1c35hIGANBaNRzSL+c/P5R
 HesT2iNJRygR6QPnXhDLibcM7EK6XH7nis5NIZc4Do7QLj6xZxbWDrCKxXWTliGTTJSzZ5wq3Yx
 uXrmqrobo7wkLEL2mQWBH3qL07ptvdt3HVvh0Is+ugXxrTW8JerCXBow1hVe2jMF+eT/4KH+w9n
 SDB/O+bKvV513OJvMfg711p7fysk2mTpVr/nTXFlZb1E8bLPCDUG5B38w/spoRtQ3lXYHcR43NO
 NLj149raSjrgnqKzDhgfZe9jfX6iyoysrIXIjGTTTE5iJ1uCamnjWmANfXDPDTlcvvS9uQqFOPg
 JMzn4iOUYPnINY4kCtSJRa2uRJToCe19shVYev3yQa5Fj+XMF7KOwnNxW+b+8xbxESAdroCyjU0
 FL4+TZLbzqeXQ/Alx7XVVkPgCup28UxmF5sKCG9Lxwr6pQMYIgoRnJzDWO3hypVpvvoNeWF8TTz
 JbCma1ZCGpAs5u01LpSTKoHk/qH4bofTsNzA5cN6IpzCeAglVk/Ucv9HYikRbe0DAT2Eo2+zvsH
 De61Acf0izFd82g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

When a GHES (Generic Hardware Error Source) triggers a panic, add the
TAINT_MACHINE_CHECK taint flag to the kernel. This explicitly marks the
kernel as tainted due to a machine check event, improving diagnostics
and post-mortem analysis. The taint is set with LOCKDEP_STILL_OK to
indicate lockdep remains valid.

At large scale deployment, this helps to quickly determin panics that
are coming due to hardware failures.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/acpi/apei/ghes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index f0584ccad4519..3d44f926afe8e 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1088,6 +1088,8 @@ static void __ghes_panic(struct ghes *ghes,
 
 	__ghes_print_estatus(KERN_EMERG, ghes->generic, estatus);
 
+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
+
 	ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
 
 	if (!panic_timeout)

---
base-commit: e96ee511c906c59b7c4e6efd9d9b33917730e000
change-id: 20250702-add_tain-902925f3eb96

Best regards,
--  
Breno Leitao <leitao@debian.org>


