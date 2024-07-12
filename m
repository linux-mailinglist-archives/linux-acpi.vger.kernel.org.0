Return-Path: <linux-acpi+bounces-6870-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EECE992FC38
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2024 16:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84EF281D10
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2024 14:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C48125D6;
	Fri, 12 Jul 2024 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RiNOb6wt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D20213D62C
	for <linux-acpi@vger.kernel.org>; Fri, 12 Jul 2024 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793279; cv=none; b=MWcFKu5Qia7P6Lq1bDOCmXUlMSserUyyHvqub1C4YL+2fRJe7wkr0pnDAbPlVNEwlrB8dkzfyRCO91T4t4tfxzirqJOIZbXdI1KAC4VhmT9j3AhXf8DNu+SXmpWfQ9qlIReh+obbYjfU94MbNSBQaOlhGccN4XsnVdGVgnkexAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793279; c=relaxed/simple;
	bh=/lu/YbF1aNll+HjNbHWkG93ZtQuuh+pwZf6wLzDnLA0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dEUlkoUxI7qC7XBKh7fA5znau6d2MpIv239r7jr3JETzeBtQEKmRSJzZKo+Vy1E7DyTERS5kdKbyrmWGymq7Cjqao4I7RHlgIjBKj1HJtMSJQCk4U+vifpWygKMvde/6h5I3e76H0cQYv1lKLLuz+IPiIdlscyw4uR+6thTxAG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RiNOb6wt; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-25e2cc76becso890905fac.3
        for <linux-acpi@vger.kernel.org>; Fri, 12 Jul 2024 07:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720793277; x=1721398077; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M7SLzqPOhG1bo/AsEh3dsR4iQc2yZ8xkH/fKsF8XGM8=;
        b=RiNOb6wtKdhfSALX4Jrc5PYGudVIiokPpTOWsIYGCzOiOPupFFq2W3nLcvDdphuci6
         oy2dFd3DqbSyQV9IKewKzQT2AqhQXrIX0w2zvwF8nVhQOLpiz5Ktnj4jkYS7aTO5LU4/
         cevv0J/QYIaiZEaJvSxPgPO+J0B19gMkKwYlnGiZ1j83mH6KH0Dz9cSQPuFYiUwLEfkQ
         +K0KaTrH0zGh8i18iW3rPHaENdY1hK1d4dGppRutvZx9HBBeJdPImP7oHQDkijeTGdD/
         ABboiJ74acGGRxjJsnXZ7SLg7WeqHvelIwhBZL+nC2T1InV5ovoGQYmC1fZPyfwTf1Xp
         8vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720793277; x=1721398077;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7SLzqPOhG1bo/AsEh3dsR4iQc2yZ8xkH/fKsF8XGM8=;
        b=k1Vi56VcQsf5SY4Rx5LytOWRck4AehygQGoiR2mn+8ay8SbVK9hW2qO5yzsaPPiI7O
         1IIGPKtOh+WjTRJACKWsZ9cD+VxgD68Waag36H7Z4lXW4dW19XWEa5iTAH2vmRV7iKib
         +rQ9moSgn74vydygaQgWQEK/VDm5cyeF/IkHOt9p3S367WC3LM4VkbbvYG1HsfhcF0p3
         IFznsc6c43eNgSRaJAmujg5xeh6Go84dBR2f/yaPIXGIvguACSqIuPEnNg0tXuo7EI9m
         yvjt6jn7fLWyTcIbxFGGFygk+q4u+qragYe66iAxsHbVcQYScZDyDnGtPITq5xAg4Hk7
         RWnQ==
X-Gm-Message-State: AOJu0Yy3PMZ2mM5eSjSu/e6WKUxkhu5tVaL09jNbqSXQaRjdVIjs70Rs
	K41f5Yf/wunlxwDRSVy/sCuXHftoynckfaaTi4yjKi5ACxqmgQnTuS3/1NaHNUM=
X-Google-Smtp-Source: AGHT+IHCeD0358ge4HNkM3H81pqlG555euJVMEwaoEwo4n0WPQTJWsTXdd2kiKViGs12SZwxGrmlpw==
X-Received: by 2002:a05:6870:c69d:b0:25d:f6f6:ae2 with SMTP id 586e51a60fabf-25eaec95a9bmr9402813fac.55.1720793277172;
        Fri, 12 Jul 2024 07:07:57 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:d26:9826:56eb:a2e5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25eaa083bbcsm2246389fac.26.2024.07.12.07.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:07:56 -0700 (PDT)
Date: Fri, 12 Jul 2024 09:07:54 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexis Belmonte <alexbelm48@gmail.com>
Cc: linux-acpi@vger.kernel.org
Subject: [bug report] platform/x86: hp-wmi: Fix platform profile option
 switch bug on Omen and Victus laptops
Message-ID: <bfa4aa4f-3c62-44a0-a398-b35d027b67e4@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Alexis Belmonte,

Commit d23430233494 ("platform/x86: hp-wmi: Fix platform profile
option switch bug on Omen and Victus laptops") from Jul 8, 2024
(linux-next), leads to the following Smatch static checker warning:

	drivers/acpi/platform_profile.c:161 platform_profile_cycle()
	error: uninitialized symbol 'profile'.

drivers/acpi/platform_profile.c
    151                 return -ENODEV;
    152         }
    153 
    154         err = cur_profile->profile_get(cur_profile, &profile);
                                                            ^^^^^^^^
Profile is supposed to be initialized here.

    155         if (err) {
    156                 mutex_unlock(&profile_lock);
    157                 return err;
    158         }
    159 
    160         next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
--> 161                                   profile + 1);
    162 
    163         if (WARN_ON(next == PLATFORM_PROFILE_LAST)) {
    164                 mutex_unlock(&profile_lock);
    165                 return -EINVAL;
    166         }
    167 
    168         err = cur_profile->profile_set(cur_profile, next);
    169         mutex_unlock(&profile_lock);
    170 
    171         if (!err)
    172                 sysfs_notify(acpi_kobj, NULL, "platform_profile");
    173 
    174         return err;
    175 }

drivers/platform/x86/hp/hp-wmi.c
  1238  static int platform_profile_omen_get(struct platform_profile_handler *pprof,
  1239                                       enum platform_profile_option *profile)
  1240  {
  1241          enum platform_profile_option selected_platform_profile;
  1242  
  1243          /*
  1244           * We directly return the stored platform profile, as the embedded
  1245           * controller will not accept switching to the performance option when
  1246           * the conditions are not met (e.g. the laptop is not plugged in).
  1247           *
  1248           * If we directly return what the EC reports, the platform profile will
  1249           * immediately "switch back" to normal mode, which is against the
  1250           * expected behaviour from a userspace point of view, as described in
  1251           * the Platform Profile Section page of the kernel documentation.
  1252           *
  1253           * See also omen_powersource_event.
  1254           */
  1255          guard(mutex)(&active_platform_profile_lock);
  1256          selected_platform_profile = active_platform_profile;
  1257  
  1258          return selected_platform_profile;

This function implements cur_profile->profile_get() but:
1) It doesn't set *profile
2) It is supposed to return zero instead of selected_platform_profile

  1259  }

regards,
dan carpenter

