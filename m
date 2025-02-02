Return-Path: <linux-acpi+bounces-10877-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06956A24E65
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Feb 2025 14:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F02BD7A1AB9
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Feb 2025 13:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468AD1F2C22;
	Sun,  2 Feb 2025 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e57Hj9Fg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1071DB150;
	Sun,  2 Feb 2025 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738504303; cv=none; b=mgbEd/XVNftOpfYtPh/YD1qawCEsotIlZ+WZQyIbSTk9avaaSW4Mqni7BsuEJclXPPGF5+CFEmyKGvoOLmEQJEfDQGLn1GF14lFhR/0jZG7p936LFGABwWjvVlewWk77ZbUyJ7C22vkv+CEjpd8Gfeo5bDmuECUr8+ngjRnICHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738504303; c=relaxed/simple;
	bh=PaGoCznYxYB4uebkg1d0lQjC9KknA3MW3KGowHSAOFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTkbukfN9KQDX8diwDsGI10tqqsrBSv/POWS1At3XgGXBDnoESMILlkJRTYN1uj1obsk2J3YfXgKDuw4pNwNtDC4rvyVshSF9gQ7Y66vnC8ypmnpcN0NWzjWCzyIjG79yxbciZiXWyAKpcoJA8Ct9DTZJtcKyWzAtvkDO601210=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e57Hj9Fg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21661be2c2dso58266215ad.1;
        Sun, 02 Feb 2025 05:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738504301; x=1739109101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fcPdAlmSrROAe9gGhBlGWoPyUgAHcTFNljv1EQXHqYY=;
        b=e57Hj9Fgrwms9N1wZRhafPTsJKcIZa38iUhMLpdVZmGTQNEA/3uebUaziJ9IOTlPxl
         oMGUox8sMgsE9ugvHbrXdkxGl+N8DcGjeg4PS4W+MaEZTD4/VWAScVdwDC6yqv3EQLZj
         FpLOlXc7bzf+K0Y1YYVpVGECdTmo+M7QHTMU0UZjRp2+9DNEAWkJF9PfD3p+o3OBQQ6Z
         y6j6tHnTh/xLaBl1jfUvm9tyN696XAdi1OmUZ0Zrx9+gNs3JBHrG5rSTgGoXA7C2yvLh
         N0augv82KpxPhweImAMVH/DgVs0NnzyJGOWr1hvwCJcuwf4ncBCdohw6CJrL6Ht+qKHQ
         n+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738504301; x=1739109101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcPdAlmSrROAe9gGhBlGWoPyUgAHcTFNljv1EQXHqYY=;
        b=E382dkph3ZUXW/wAQQ970IE/gJ+JATYfKg34aSXxMaa1tLRzceebkndzWS6m7R9Qsr
         VZtnS+bVdgJaDEyt635m8kv0lhEd+Xf7lS99O76QX0/6k55zmkGIjPjc8LltG44Qtyu9
         2Us+O/SrDthIZ0vQDaQWLO9NPv1PbWxg/E+q8T0b3ApFE8VZhZvbUNIIsYyy241GOg2N
         jyn+aeO/xdNFr7ZhV131h32XxHJx7GxRaQyIY6kcd3fcZcfahYjlv+MIXxWHcScvpKXL
         lFU4QhZVAH7IOQbT5IMIlJvGPcS6eZC/yvlu7Qz4wL96ErUiu+VtBZ9eHlMxIeu3N5zR
         R+MA==
X-Forwarded-Encrypted: i=1; AJvYcCVu/7hIiAQrEYfs7mmnZGKiS60v88WjOdD2MrR01qecwZJ88DjCy87IhXe8yg8Wo2Zh0mq4jjRoVhV77N7k@vger.kernel.org, AJvYcCXtsD9AJR5Rya2dTTS7uMHfAuEUR/BmcRt810f7xccb2j5xPq8fpg+HYHsgTau70t0VaKe3TQ72/asV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv3cBci+qJrJkNDlSN2ZgbPyeofDoi/dQAeKEeKtBPodMfHYhF
	JjAKKExMvfXuk5ykKNuBnprqny8dPgDxcUZ+eixiKSTxo6eeiW0q
X-Gm-Gg: ASbGncvBPoa7gXU64+r4vt7ZhRdMChXtYr2ShhE+8gxMAbDCPUIoKf0XR8JZYhdJOnc
	CEwucvhGBg4rhqgXmW9Pj1eX077UKK7nUqiizO+S80ZfI/BvTmvbGR3oKf5HZ5mzEJ87xGpXtRO
	wecS4dNus6t+EXYe1QQFJe4uJt05bjP6QgqvtCsNTu+TY6kUTPOB0Ik1y5MXf0IQjIu+W23fimj
	EAmkYHhGcTPhyOyfSxn8QJCYJ5sQgZ5CB6vtuYaiU4cpEu6UfIqzAIFLAtvLwH5+FdVyxFy07dB
	v9s8suM9nyeH3aCAdnXWhKxg
X-Google-Smtp-Source: AGHT+IGSrt5p3ZW1z1QTxJFz4FNWGjTmymX8g7rfyX1880uET2qfvQtym1j/XhhlXAUGGdw2/o+AFg==
X-Received: by 2002:a17:902:f610:b0:216:4348:149d with SMTP id d9443c01a7336-21dd7dfb835mr324407195ad.53.1738504301080;
        Sun, 02 Feb 2025 05:51:41 -0800 (PST)
Received: from [192.168.75.213] ([116.121.188.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de3303cdbsm58016825ad.199.2025.02.02.05.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2025 05:51:40 -0800 (PST)
Message-ID: <9edfb12f-5e1d-4de0-b124-37053125a7e0@gmail.com>
Date: Sun, 2 Feb 2025 22:51:34 +0900
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Weighted Interleave Auto-tuning
To: Gregory Price <gourry@gourry.net>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, ying.huang@linux.alibaba.com,
 rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org,
 akpm@linux-foundation.org, honggyu.kim@sk.com, rakie.kim@sk.com,
 dan.j.williams@intel.com, Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
 horen.chuang@linux.dev, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com,
 kernel_team@skhynix.com, 42.hyeyoo@gmail.com
References: <20250128222332.3835931-1-joshua.hahnjy@gmail.com>
 <41ab5a11-f8d3-403c-9d68-33eb15aef8fa@gmail.com>
 <Z55QmybX5IkuLv6Q@gourry-fedora-PF4VCD3F>
 <Z55RpQgsma5wrpfh@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Honggyu Kim <honggyu.km@gmail.com>
In-Reply-To: <Z55RpQgsma5wrpfh@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/2/25 01:53, Gregory Price wrote:
> On Sat, Feb 01, 2025 at 11:49:31AM -0500, Gregory Price wrote:
>>>    1. the auto mode set the weights as 10:5:1 for node{0-2}.
>>>    2. node2 is offlined, then recalculation makes it as 2:1 for node{0,1}.
> 
> Point of clarification here:  a hot-unplug event won't cause
> recalculation.
> 
> What actually causes re-weight is hot-plug reporting new capacity.

So do you mean re-weight is done only when a new node is onlined while
offline doesn't trigger re-weight?

I see node_set_perf_attrs() does recalculation by calling
mempolicy_set_node_perf(), then reduce_interleave_weights().

But I'm not sure if the re-weight is done via node_set_perf_attrs() only
when a new node is onlined.

Could you please explain where I can find it?

> 
> So in this scenario, the weight will remain the same for node2.

If it's true, my scenario is wrong.

Thanks,
Honggyu

> 
>>>    3. the auto sysfs interface is set to 0 to make it manual mode.

