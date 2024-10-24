Return-Path: <linux-acpi+bounces-8947-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3ED9ADE78
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2024 10:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D3D1F23244
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2024 08:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C991B0F1F;
	Thu, 24 Oct 2024 08:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7hm6jgr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FD81AF0A3
	for <linux-acpi@vger.kernel.org>; Thu, 24 Oct 2024 08:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757243; cv=none; b=sAhMf0CFdF0U88qJk0+1pi2lUJrhpfuPeNKPGDUv3JIqC9arhhNhh4tj3/8Qa5+nX86ZFKuY64cn/nuncGCmuXx/SEppvOfbo+fSF2OhI29d5tnZpcpIP46EpB1t2z+jq0EKL8G9UwN+m+0fSV+pSQ0HpyZ/yYIOZ6BbQBo7/hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757243; c=relaxed/simple;
	bh=lKJz69FkZU5PsLniCJS6Kxeee5PW8bbqpC3sMQ+Zazw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ktOqVats5NFETP02/puK6tj0zC9exy7e+pECwk2KarjRMBPeKImA5V987AlIRtx6Xn4iYp94alBuNLQCGmriBLHRrFUwQa4o9bJQYY9juostiZU0DMl+dVoJ27swEl/7EhIx+CJBJVVBFCKObxggC2RFC+mlOrMsZtgYajItvhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d7hm6jgr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431695fa98bso5974575e9.3
        for <linux-acpi@vger.kernel.org>; Thu, 24 Oct 2024 01:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729757240; x=1730362040; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EZy5UEggNFqbZ16nEcVpQryOaoa0SiPbjloEPBK8vjw=;
        b=d7hm6jgrWb+CpMFjECvjUGI4pcH2mxDXhkDqEy5nR7ZSqzof3lomaaCW7BGLYOiuE/
         PSIWBvyzijruYqJ5+Wnrcl912L1kitj//+k3QwKEJVjnrbrLVZ0mtvNyqRU13E4lCN4H
         DoNdmvs7OApWYX28oPIS7wUszXWRB0DcRhIUsae5yXmA0wc+3iIeoe3xy7lJl4MNGQyH
         /r68XOSxtmP6hdvnraj8XvnfwYhBUtIz4KpYn3U//6OQekU/u0FfuKKuNqnryEokXcLr
         gjf/zVQGxzKGnvUBSvzVMJomvO6RQoMRtmkgWML18l9zPUsi9edh+CxnMAG28BcH+JTN
         wujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729757240; x=1730362040;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZy5UEggNFqbZ16nEcVpQryOaoa0SiPbjloEPBK8vjw=;
        b=wh44RDC/3nk+cv0owmG3Kb14M82hymkdMfou6W3q2MchrBGPRD2HmgYZOXorbWsdNS
         Sli2RJpSwRqMZazdcLgf49SFwzQMHNbL2vSo9mi2wZpxGYaGNIlhmvvOD9Ft01pjKwb0
         /CaLwK3kl1uYFpdMa2enFgUst7sw34+4NJMa3iNbtrwi18MP54Qo+VquQDyxpMON6D8Z
         kW+zGZJiYRNd9Y06de+FL3yRBMOwkPNPolYwUWurFUZ6aBcW1tGwikvPg2r7l4K1wkYp
         OhqLn//nUQ5XY8NJbzOX2evfP51E6R6B/Nq/eX69nn+gzPfmR9pw3FVsVFdM1fy4My1S
         XLqA==
X-Forwarded-Encrypted: i=1; AJvYcCW6TEGmdUo1FT1hmslb7m+Yuqz75t8b3Ngtbr6gnijByqDQzP7kQm8f4aH5SzPCvPcVf4b690Z4q6ZL@vger.kernel.org
X-Gm-Message-State: AOJu0YxiagRzZuUjDb9z/xiFO+aDstEGScvghH+J0jGJqgTi6ELCRHkT
	O11Jg/ZomqnBrlkisXiaUN6KrljI8mWs8TPGXLJEJIanM/WQKYKrtkb9m+fzdSA=
X-Google-Smtp-Source: AGHT+IHj3dTiTdI/Cfg0wXRcMpCa/DQvbUN9eHqbQfyoSZ5v/QASIQRyjUyPWiqx5em0P01hF5B1ZQ==
X-Received: by 2002:a05:600c:5011:b0:430:54a4:5b03 with SMTP id 5b1f17b1804b1-4318c6e0175mr8691295e9.6.1729757239721;
        Thu, 24 Oct 2024 01:07:19 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c0e132sm38394125e9.34.2024.10.24.01.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 01:07:19 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:07:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Koba Ko <kobak@nvidia.com>
Cc: Len Brown <lenb@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] ACPI: PRM: Clean Up guid type in struct prm_handler_info
Message-ID: <3777d71b-9e19-45f4-be4e-17bf4fa7a834@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Clang 19 prints a warning when we pass &th->guid to efi_pa_va_lookup():

drivers/acpi/prmt.c:156:29: error: passing 1-byte aligned argument to
4-byte aligned parameter 1 of 'efi_pa_va_lookup' may result in an
unaligned pointer access [-Werror,-Walign-mismatch]
  156 |                         (void *)efi_pa_va_lookup(&th->guid, handler_info->handler_address);
      |                                                  ^

The problem is that efi_pa_va_lookup() takes a efi_guid_t and &th->guid
is a regular guid_t.  The difference between the two types is the
alignment.  efi_guid_t is a typedef.

	typedef guid_t efi_guid_t __aligned(__alignof__(u32));

It's possible that this a bug in Clang 19.  Even though the alignment of
&th->guid is not explicitly specified, it will still end up being aligned
at 4 or 8 bytes.

Anyway, as Ard points out, it's cleaner to change guid to efi_guid_t type
and that also makes the warning go away.

Fixes: 088984c8d54c ("ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM handler and context")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
---
Sorry for the unfair Fixes tags since you obviously aren't to blame.  But it's
more practical if we avoid breaking the build in backports or etc.  Fixes tags
are quite often unfair in this way...

 drivers/acpi/prmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index d59307a76ca3..747f83f7114d 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -52,7 +52,7 @@ struct prm_context_buffer {
 static LIST_HEAD(prm_module_list);
 
 struct prm_handler_info {
-	guid_t guid;
+	efi_guid_t guid;
 	efi_status_t (__efiapi *handler_addr)(u64, void *);
 	u64 static_data_buffer_addr;
 	u64 acpi_param_buffer_addr;
-- 
2.45.2


