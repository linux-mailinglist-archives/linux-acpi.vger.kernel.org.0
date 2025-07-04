Return-Path: <linux-acpi+bounces-14989-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D3AAF8704
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 06:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3207B485C46
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 04:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3351EF39E;
	Fri,  4 Jul 2025 04:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cnO60MTk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C0772612
	for <linux-acpi@vger.kernel.org>; Fri,  4 Jul 2025 04:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751605036; cv=none; b=JWfG96IztPXqA0BAYpVmjhOkfFf3VWiJlNOknUJ7pGE9KHpQGCBFSHIFyXVAqfMIvetnT5H0fhzMFdSaBNlHXrc1CWcIThdas1u4qKH7r69ZKC7dr4iRPszd2EqWqU4WQ5L4upZDeY33Uek9I0ExlXJM/r/DamGtB8voI4vE2Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751605036; c=relaxed/simple;
	bh=FDw4ZPy3X7k/Beth3BEz0O00Bzcr7Wah6dBowmHyKVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGngEY1k7dd9NodJKvu0Bet7MvEZRp+cR9aMku1j7XOWAx2crkksg0ubMiiQhVxXuDjFSCD5oz208p7Z5646idHXT2LwcC+0Ul/wTDBN/chuaiXxxk94QFDpWOkqOVjx/U4wAv3trqPCJgyaFNzirQyTkDaHn9lJ25wJ1mzF09c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cnO60MTk; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313a188174fso1487969a91.1
        for <linux-acpi@vger.kernel.org>; Thu, 03 Jul 2025 21:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751605034; x=1752209834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FDw4ZPy3X7k/Beth3BEz0O00Bzcr7Wah6dBowmHyKVo=;
        b=cnO60MTkGt4M+jPTL/G4OLyjBYQc6DUTWK56Xs65vP3k0GYfhk+DhZDniaWoDmHlFv
         LnC+x2AdF1sYK+niuEUwKD9RB0CQe3S/imgZycbSk9BYK+FCB6Xp1xrahmYJS0T5iygU
         mHV+LF7sWDfqIjjTUDnE/IFyAdZsWs8PLSPAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751605034; x=1752209834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDw4ZPy3X7k/Beth3BEz0O00Bzcr7Wah6dBowmHyKVo=;
        b=wZHoiUFmBnwbK+gwLUoVWGc6s7cgtNzWGjpHbB4wYnxqi6K6fAozkggXWlYuDC5olw
         Lsk3s2SbZRAW9thkUKkQobJMF79l8oXkYSOVjRZdbe58N7GynpC2vxHOl1upz3yJpofK
         IOeL1MGxqr1refW41KBsaj6A2bGKtU+rNbSsyNjE61NvQLOlnU1qxgOdVX2aRUyngu4a
         0FcgYTy3Pi9y24MyZT+2rUUZZgEKVMb+Xam+t+UmIi8tvf5TMW0YtjRN9l6OMt2Lhibx
         XWVrCedHKHOsj0MNLFH+GcSTD76r487X9l9LA7kaw88GPlhSBFHq4OAQQ8VH0+3Ge/lF
         S5ng==
X-Forwarded-Encrypted: i=1; AJvYcCUaZmm+U1+SN/w7C7fBVf8LRZ5rfeIrMxfyk06yZ1H0EW2+dngJI00+UDTbE5pjwRtv4EmkNWwqaAFZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxSRslNDlqXLlqKYNbaJKeayE6M2xufbxd6QkHHHJlL7Iqy31jy
	6EOoXAn42LVHPu6btOdYRJuhSD4XzqVKvngNsRM2fg1amDYsqWaAR8YaeP6ldw607cDVAU9j08S
	Y529wzmkJ
X-Gm-Gg: ASbGnctsS44Mw7roWDGx5dtGBNalRcq8p5cTtDikoF3ZY7XkQiaUKTXvWikl816qsaK
	NW5f+Lz7mKR+WbDw6FksXMP1tforRbycY0ccITOc73uCegxU3xAHMUXeZM2K6m40/Ntrm98THR+
	yRszBmvXAMl+ioSIOww40j/gJ+ru47NEnrtPjtk2vJs21XskbhrU4sbxF77TxPdrKonE4vKeQGJ
	8VnC+loW8QjlJOyrsfQR8hq7Ee3++0geui1y/qQRZQyagyH6zgxBQgQe9oLSG0UoVa1qGxfwyA/
	LNG/VYwhUuZ+ZbzLLFoY34EKM2LySYv9Et9yLIceN0zHEcyh/myvFg2oUJpwaBV+lE9EGkJam4r
	QxnDL5US1DpM6mJbWEUwMjxZj6MnaL8M8b1O3D84sMg==
X-Google-Smtp-Source: AGHT+IEKjRxue/ANPyQe0osnzeFim+jxBdcsGsD/fKf/nU2x/OonSsNMnuefJj20cHAehtNGidiQ6g==
X-Received: by 2002:a17:90b:35c8:b0:2ff:4a8d:74f9 with SMTP id 98e67ed59e1d1-31aab8cc9bdmr2493146a91.10.1751605033820;
        Thu, 03 Jul 2025 21:57:13 -0700 (PDT)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com. [209.85.214.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaae5dfbesm1059016a91.15.2025.07.03.21.57.13
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 21:57:13 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2357c61cda7so249035ad.1
        for <linux-acpi@vger.kernel.org>; Thu, 03 Jul 2025 21:57:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVBhf3Xk84mQPRh+SiRQCjdSyw+Kku8fJlbzIyM/ymg+auSzGaQzbVaoX5rgIEc+SED2fQGzYfI4NQ@vger.kernel.org
X-Received: by 2002:a17:902:c405:b0:237:ef9c:ffd9 with SMTP id
 d9443c01a7336-23c79adac6dmr4437795ad.2.1751605032342; Thu, 03 Jul 2025
 21:57:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87C1B2AF-D430-4568-B620-14B941A8ABA4@linux.dev> <84dfa466-d201-4a51-8794-6c64568bec95@kernel.org>
In-Reply-To: <84dfa466-d201-4a51-8794-6c64568bec95@kernel.org>
From: Peter Marheine <pmarheine@chromium.org>
Date: Fri, 4 Jul 2025 14:56:59 +1000
X-Gmail-Original-Message-ID: <CAG_X_pC0jTe5fuNaK81veif-p9JeJyYpgb2E2R_RXBzfcj4_MQ@mail.gmail.com>
X-Gm-Features: Ac12FXyWqCjWEIleUBl_ePtV786t5G-mg7Cm4JbPyPJYEHruTXbvG1LIQIHiEZg
Message-ID: <CAG_X_pC0jTe5fuNaK81veif-p9JeJyYpgb2E2R_RXBzfcj4_MQ@mail.gmail.com>
Subject: Re: [REGRESSION] - Multiple userspace implementations of battery
 estimate broken after "ACPI: battery: negate current when discharging"
To: Hans de Goede <hansg@kernel.org>
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>, pmarheine@chromium.org, 
	Sebastian Reichel <sre@kernel.org>, regressions@lists.linux.dev, stable@vger.kernel.org, 
	rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I'm not surprised that there exist a number of userspace programs that
assume the buggy ACPI battery behavior is the only one, but this does
leave us in the previous situation where there's a clear bug in the
ACPI driver.

> But, the patch was actually doing the right thing, according to:
>
> Documentation/ABI/testing/sysfs-class-power

This is the key issue, since it's entirely plausible for a program
assuming non-negative battery current to run on a non-ACPI platform
and misbehave in the same way. If we're not going to fix the ACPI
driver to behave as specified for the kernel ABI, then the ABI needs
to be redefined to reflect the actual behavior. It's either that or we
give userspace an opportunity to fix itself (and I'm not sure exactly
how that would be done such that the clients which need to be fixed
discover that they need to be) and correct the driver's behavior
later.

