Return-Path: <linux-acpi+bounces-6849-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8712092DF47
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jul 2024 07:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7001F23614
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jul 2024 05:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899E625601;
	Thu, 11 Jul 2024 05:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="C48xwAvN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65931773D;
	Thu, 11 Jul 2024 05:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720674260; cv=none; b=Jeo+8EqbcuSJs8FwEvdmztpwZiDxeWaMs+Qxghg4CMVIzI1dYg8EiP4C0J3SWn3HfPNHtRrD0toq6vVry3OWaLx+Lfi1LKcI77uODEzJVU6czTc8miLw81ndTHeKXehwbEhsRJ6+SORfe3btSuSZU/k7DRVaeIzVuKvyxTAq+Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720674260; c=relaxed/simple;
	bh=Q4MBlwl9OXI3hSma3aQJZu/r7nzu50ST+jHSSXexhLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pNzzpam6pwevBx5xqhg3W6ThVcSet4+feW2pcsY/mIeAsL2RstYWxKltb8wfYOcKpqPp5Yp7veYWqYo5M4AtKVEbBiVary1hdsvgc6JnPNK3RppoyRsq0aiDog+GWfO4BeS6T8VtpNbpPnYLUH9Bgrp4H0XZnEow2mqt3IaHFek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=C48xwAvN; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58bac81f3f9so543267a12.2;
        Wed, 10 Jul 2024 22:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1720674257; x=1721279057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6sYreizhuqo9VEsBiv5zn1K4ARET/poe7dXPWpKrDg=;
        b=C48xwAvNCSU3D7xSuMBht8sou+bWxDHAIIyxEVtIAy1e5rk3BGPRMc+Et9or2Gb5XJ
         QwZvVTHKQ2tkscJEKgGGu1Yqs9RgoWND54qVVHZzdsMPUJ62q59cpROQJ4cHft/3to8G
         OUQ5HJ+aKvXcOQQB2A5z/2DFHMC6Rt4GUTqMROkuKsp+ot9XaPGanrm+X1D4SMb0Ja9Q
         LOQBTdMLcRfiAXHFmtrakIY5ql7DgzQ2Uwgn4wuXnJtAY0+sezuHmnG3zg5K8VJGsDF6
         mMV9b8S5eJtb3o5AVu3OUqFbGoLC7PFhthkoJ/Yo9JgM8rFi5KOU+IAwJH+PBPG8RJXP
         dhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720674257; x=1721279057;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6sYreizhuqo9VEsBiv5zn1K4ARET/poe7dXPWpKrDg=;
        b=DxuoVHSUmKFYV/PemcBSXe8WS5hLXPi56RkCaTzGoOJo8yMBq31GJ6owh2RdqZJ/6O
         wsbVlDeYizBlExSw7pw0m6vu+pdh/5l3LQnUzudYDmkG1hOpKpYE4QVyuNIl8Jz9M6ZR
         c2q8b/GndyiPKCiAkj0/NM52YFl233pyuiJ++H58441QcdoDw+hwk/C4KENvHtbE2R4L
         KknBULmL80WlTk+g3umxAzfFuXEbK+pRE5l73y1H6XmKde8UUQq9f2X+Vo0mnzi3EwcI
         TvrYCBTx+husBB0nzd7I0HmdHQef2IQSXC8xxc2x4V+UnAuZqzxuMuxpnESTu89G8kql
         TNug==
X-Forwarded-Encrypted: i=1; AJvYcCW6de/5i06n82erbbWw1HQz4X5HiF8rtH29uXrG+Qf8ySxDuavTXnfEH8VXxZB7QTuBAHwDd1eEf5ki2Jil3YFgCrwHbyYSaetcqw==
X-Gm-Message-State: AOJu0YxZDwVSGQW9o0jyTs6lFuWI7+mv+UnVeiZn7FGwVOZrIFEyPquP
	GqIYAcDDD5X7xswDFqWZMeLjLBVdhXPM8dntVslGsSDGq2mpUPmT
X-Google-Smtp-Source: AGHT+IHknFLpemeBhV363ndCC0fObsF10p56FwSMS0PTIBI6wiHbEiBGmgK94B0II6BneqramvYosQ==
X-Received: by 2002:a05:6402:510c:b0:57d:3df:f882 with SMTP id 4fb4d7f45d1cf-594b9b0473emr5060906a12.7.1720674257080;
        Wed, 10 Jul 2024 22:04:17 -0700 (PDT)
Received: from [192.168.200.7] (p57b87956.dip0.t-ipconnect.de. [87.184.121.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bc4e8255sm2982173a12.48.2024.07.10.22.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 22:04:16 -0700 (PDT)
Message-ID: <454710cf-38b4-459a-8b5f-e40bcd7f20e8@message-id.googlemail.com>
Date: Thu, 11 Jul 2024 07:04:16 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression in 6.8 from "ACPI: OSL: Use a threaded interrupt
 handler for SCI"
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <205bd84a-fe8e-4963-968e-0763285f35ba@message-id.googlemail.com>
 <67d74985-7be5-4e29-aab2-97a08208ca3f@intel.com>
 <CAJZ5v0i0jJBDqYjp+9_Bmhhf67SrWNXaRY1ZfDx6GEKfCLcGVQ@mail.gmail.com>
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
Content-Language: en-US
In-Reply-To: <CAJZ5v0i0jJBDqYjp+9_Bmhhf67SrWNXaRY1ZfDx6GEKfCLcGVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

Am 10.07.24 um 15:13 schrieb Rafael J. Wysocki:
> On Mon, Jul 8, 2024 at 3:51 PM Wysocki, Rafael J
> <rafael.j.wysocki@intel.com> wrote:
>>
> 
> So can you please check if the attached patch helps?

Yes, everything works perfectly fine with that applied.

Thanks and best regards,

	Stefan
-- 
Stefan Seyfried

"For a successful technology, reality must take precedence over
  public relations, for nature cannot be fooled." -- Richard Feynman


