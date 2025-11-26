Return-Path: <linux-acpi+bounces-19300-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B713DC8C45C
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 00:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723D53AA9DD
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 23:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C4F2D2394;
	Wed, 26 Nov 2025 23:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="XkTJr23L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055BB218845
	for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2025 23:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764198037; cv=none; b=farWcIPd1pcgj5AZS+WG/wr1pGCWDE5IsVhBREXXYQ6awj28FC2S62mZKhizN0H0uQK9SDwNqMHPVo4ylElluNrKEOPfSkJaLjHbnZJgxMyfvHnUsNJWpHUXJkUSvp8ax/RsD7eBTpxYI3x5sHs1vka/UBGh1Nfk9fUxhHyxWyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764198037; c=relaxed/simple;
	bh=PCSoXnpEk3pcBjDBHwldkbFyBOfxd01QtGIpFU03GsY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=uIwiQYwsU3sBtoIrKuZppDbL8OrAvwdipixLDaOMYAVN9T9IU2XkHpLpXZVZz5iJqA+aITIKIbG04WZFqmOkrug4BdHunI1BZlfo4+ABmsofm4EloeuZyMqDwjWox0bBENnoE5FJ3yqH6LpSTcV3N3p2Qzy+fZGiCXr2ynuPx6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=XkTJr23L; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-4330dfb6ea3so1429885ab.0
        for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2025 15:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1764198035; x=1764802835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:organization
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCSoXnpEk3pcBjDBHwldkbFyBOfxd01QtGIpFU03GsY=;
        b=XkTJr23Ltz3Gws0weCYDMAQRz3HrZADjE+qlLXWmy3CqViWpDaHsk8CTDa9Z6SK8af
         CwdgcZQhSLaIlixnf/l7XjsZ24f8nPLoP7JQQTNTnbFh+RvFvDybKAEF28kBcB608kxO
         sm/e7qV99i+jf5g3fhsv9iAGm/dHxyhCTiSDAc9DL9Y/lJj9493+A0SJPoXm0FX6CEfZ
         8cjAZc43gKGtWsUWj2241RQMryE8R6uOFqmKsOpo0KkmfrOZkfAuKX6Q+lDc3oNEajq/
         6sgvczQDFawlORlLwdH+QW6R5sWQ6PV5gvCe/8LGoA/pLLFwbh350qx4Sz1tA+YppMA6
         NHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764198035; x=1764802835;
        h=content-transfer-encoding:mime-version:in-reply-to:organization
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PCSoXnpEk3pcBjDBHwldkbFyBOfxd01QtGIpFU03GsY=;
        b=UxvP8ShQAq1qXvxI8lmwuPBuMcaSUCjSB1Vru9TXVMTNe1DDSZglfU4hgxscGZxLDw
         1lTnmmwSm8XW1R9CIgMkvkTlysmNDTaYd7ovhpWofEuE4WgjxC7tWqfkw7sqT6v5q1AV
         wnCLccGd3rnX70nfpfbLuPXO3Oe42ybblJB/ngeR21sFF+rSkJTt+0cmZ39al+zbJn+F
         VkJ1VTMLKrE2LOPuDo275nzQMPj2Es4rBXlo0rv90f6OPGPTLbUTvZxhLxJ324g/m/LW
         d5HNUQBJ3xFiu/FdPTtNpOXyA7DaChz+IAop4HFfQVt7mzWeVk3+1NRYuDvHkryJ3qg8
         t0Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVyGJqfc1krcVNNdEvEdOuozwRWdjpa2okof+7Odvi0sb71NjWZKW65hL8MCOdu6knRWsTW65U9czS7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1zXzs3Abh/Odw+druPogM+BeJ5w2O4j1JplrmkL6hmf8urcif
	zuJv9MxK6BKbprAbFqtXNPfNq/UcAxC8ZaGfNnOvN2Yqq5v+WlSZWGvyvFrLosBXMhXY21do69o
	3w0aF
X-Gm-Gg: ASbGncsWu4DgMajwBg2pNK9UtndWPwYLd4R+buuFRF+uwVYfP56hJC7k/CIE54/7C6D
	GBcSMGBb5H8h8/Xxln/j+jsozGkeRKFnBRb1oO0n9r+dl3zKpSzvSPok2bDPaRO1ntIPxzKu1zu
	k/DCe5o2Yf7Nyz06F+vLxe1LMn+PMpe3mdHJt/JTrKv8qk7/RafZQ27UfsA8jXEzclXYKcle8m+
	K4usL0CTgV51ehdoTaRW93RMBZdQ2Iqv1TqNLs855HlnYTlHNBTPMkpxMZB638Im85S8sEJqoHz
	0UKHvOEbvbDuEgrD5zp9JKmXRQ/G1xFQ9uD+Sfe7BIlqKYe6h8vQJ2BEwazJrTbt/YgCOWMHSs5
	8QlbzAXZsWgHRQRoHEt6w0tcnj0E7zngD2fWRC+oa4LzkffRUcbVxbny+LMiLTzoPI2Ud4hqUFL
	qWXNpBCjT0
X-Google-Smtp-Source: AGHT+IEWc+r1Rn9tHnOOwuTgILo9tXvn4RuBZcp34oCrRbA7eLq90EYdlKPbB6iWPkQIPBS3z+8L1A==
X-Received: by 2002:a05:6e02:198a:b0:433:2341:bc12 with SMTP id e9e14a558f8ab-435b9851db9mr197827775ab.2.1764198034546;
        Wed, 26 Nov 2025 15:00:34 -0800 (PST)
Received: from kf-m2g5 ([2607:fb90:bf0b:8b65:49b1:b694:940a:bfe6])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a90b6dedsm91960055ab.18.2025.11.26.15.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 15:00:34 -0800 (PST)
Date: Wed, 26 Nov 2025 17:00:31 -0600
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: srinivas.pandruvada@linux.intel.com
Cc: arainbolt@kfocus.org, kernel-team@lists.ubuntu.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
 mmikowski@kfocus.org
Subject: Re: [BUG] intel_pstate: CPU frequencies miscalculated/incorrectly
 detected on Arrow Lake hardware
Message-ID: <20251126170031.145b6a56@kf-m2g5>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
In-Reply-To: <4f534cc70650111e420d5ac9040df4e546eed336.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

(Sorry for this rather malformed email, Claws *still* can't find the
thread for some reason so I'm having to resort to a "mailto" link off
of lore.kernel.org.)

> I asked for some dumps before. We can try to inform the OEM of the
> system as this is a BIOS tables issue. What is the make and model of
> your system?
>
> Thanks,
> Srinivas

We're actively working on getting the dumps you mentioned previously
for all three affected machines, along with the model info and some
benchmarking results with our current production kernel and the latest
mainline kernel. It's taking a bit longer than we expected, but we're
pretty close. I should have more info by Monday if all goes according
to plan on our end.

Thanks for your help!

