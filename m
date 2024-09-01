Return-Path: <linux-acpi+bounces-8056-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B30B09675A9
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 11:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71441282727
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 09:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C531442F4;
	Sun,  1 Sep 2024 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hc5ws9l3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B790D24B4A;
	Sun,  1 Sep 2024 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725181718; cv=none; b=Z10unSAoMaXfWaCQVbz/bu2oTpUOu9x1zDiom71sWDTmsL1fCle2WhceCmt8DfbxDgphC2XujKLRYPDMibuvvBtbasyW3I4dZYUti7/8sbuEOqTwbK4vJIrUIu4LXEbzMvFBQV4jru8QYBqIs6EJwqqxoKuwU5045xGF7pu87fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725181718; c=relaxed/simple;
	bh=P04YwUjCOryVjCfcYQnu0tg+EzgnSL5TKqfNGDD5QM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ShCH2tCUJ6+ALn8WzCRsccVbpSeVVl/rUe62Y+XqcBlxWcZQZEHTJNSkG+zO3E13qACjL5+hfFESiyB1K7549tHgP/MoPaunVDHNDKL/A4La08WND4FM2rWQV9DPYXidS/AyhflJ6FUZa+Tu61qsKBjBxlAWouW/fhMZul3YhMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hc5ws9l3; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-714262f1bb4so2492091b3a.3;
        Sun, 01 Sep 2024 02:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725181716; x=1725786516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uf/Eq6QcdVJLK+5uWcgN0sie61+2Ba/1R5i7PSUP4RI=;
        b=hc5ws9l33sE7bcBJBg9n6jwZRWOoGe6evpA3wZ42oeBfjTDFJLNzDv+3DfloBqiLGy
         EZze7nLZ8IpyN8UgwshNIKsjHabwuBIv/ZU/7eESoWpviXVg7E0HG3mLoxf/ZeZZdOeN
         4G3HkLt2VufCo9tqvezNASl1RuvuRXxSE6ciLPuO0tnXv613VSpXpFWB8YNTC2Q8eGVP
         nGj7hVwnT9so3QF4nytEclB2n/VUAN8gqZ10dvvGcVy3EJ53ygSIKC3aIeBXir6EPte7
         OdDn026OlEzHKI6h9lkyxKs/5+9A2ZlnhVpoNnmcNiagbZqBxVzML6VJ5DJxEYp3Gq8P
         6YMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725181716; x=1725786516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uf/Eq6QcdVJLK+5uWcgN0sie61+2Ba/1R5i7PSUP4RI=;
        b=KYl7UA3lQou1MMERZicthl+DMAgf8fN5dLtHaYdZ162M3rKRqr28qfkBPaEt1iSwM4
         n5VXbpkvZ1p6GRn9TMLjImIR0dk7hilAYirtfcmmVXIXF/MmQ6FmCbdJLdDVGRd6h/u4
         ao9ERsvFntA1G7dwBerzZ7ExQAFmjEbXpRpcJXv1+30P4LxZXRMRE0qMTSovIRj6J8tb
         T8NoqALn8JLQggDIBccTWWj09WiE43QWv6VvxIMegcb2uU+x+smXCu4RcOsJH4Ii/7u2
         hGuJH4P/V4Ln0FiJPRs9LI2qEj8l0TIsAon3BQCGlLd3K1ziBtqzoPqBrWy0LoQS9KLT
         QKJg==
X-Forwarded-Encrypted: i=1; AJvYcCV0ASQ1sz4G3TwUCO2Djv1kgGqHCXawUz4TB9/TZiYnz4OkhhJ2QKqX9vKCVrnDyfka2pPLvc0qK6vSYO84@vger.kernel.org, AJvYcCVp/b9JsuVlxWswu1F60LnTUspbY8ebpN+cKErQuo0esCORfuLZucuOIqDYbQrIMRB8npbwC3JyNI5h@vger.kernel.org
X-Gm-Message-State: AOJu0YzrAjKhj6ETWuo9J+K4jtLu1VUfnYAWuhtLHjfA3lTa6FlSLp1o
	uKW8z8C7OWylrDty2JVDep+VpfE5nznWJ4IIqF9W0PISXsJbAZ98
X-Google-Smtp-Source: AGHT+IHAGAa6ehS3sdl3Svp4SmGi0hoXaI3TEwD3+VLMGce9iXE9iXi/5JFvtfwk9Hzfm5STJegqNA==
X-Received: by 2002:a05:6a20:d70a:b0:1cc:e47f:1004 with SMTP id adf61e73a8af0-1cece520b85mr3490106637.26.1725181715734;
        Sun, 01 Sep 2024 02:08:35 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c1:3a:c065:a024:d97:d9a0:1860])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20563b718b4sm6530795ad.298.2024.09.01.02.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 02:08:35 -0700 (PDT)
From: Amit Vadhavana <av2082000@gmail.com>
To: rafael@kernel.org,
	linux-kernel@vger.kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	ricardo@marliere.net
Cc: av2082000@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] ACPI: CPPC: Remove unneeded semicolon
Date: Sun,  1 Sep 2024 14:38:23 +0530
Message-Id: <20240901090823.18766-1-av2082000@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove an unneeded semicolon, as identified by the kernel test robot.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409011554.KG79Y5xu-lkp@intel.com/
Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
---
 drivers/acpi/cppc_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index eecd80e848cc..28adea68e1cd 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1138,7 +1138,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		default:
 			spin_unlock(&cpc_desc->rmw_lock);
 			return -EFAULT;
-		};
+		}
 		val = MASK_VAL_WRITE(reg, prev_val, val);
 		val |= prev_val;
 	}
-- 
2.25.1


