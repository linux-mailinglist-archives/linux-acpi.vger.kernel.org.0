Return-Path: <linux-acpi+bounces-12592-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6908CA77D79
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 16:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49DE97A1B34
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 14:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D401ACED1;
	Tue,  1 Apr 2025 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlAEN42X"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE10AFC08
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743517017; cv=none; b=ZyWG/6EuGo9w2FYe4YqiUrymSeibdSiz8GAeZS+YwlpbIegoPpHXX13Bmmj4aEglgEK29teJG5CZxX3g8+3yzigX71MT7tPVhFUpd3ejpOi/3f6+Nm+6EkeBUYLZQ/1Dp/YaCVn8aeknFKvbXOgKDLnHhnOFZDIdcLdHHS/PwT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743517017; c=relaxed/simple;
	bh=kszHA18/6azki1tpBWH9L3VooL+0tvBxBcPN8hJnk1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edKbwke+BrObAVkvnLAT6LRFzcl0AA2VxdJrPLTr/Wq/MwfaBVMS5GZ1QW/pnzYZzn4xUmuVU4LlTUF4BGsEf4HQYquznTXv4CHhgRi+4sgCNuVkvHzG61rNu2/i2QH0R3ep6nSSZJdNN7pEJVbNaUihv4SEPsabvB/red6i7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlAEN42X; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2260c915749so77559765ad.3
        for <linux-acpi@vger.kernel.org>; Tue, 01 Apr 2025 07:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743517014; x=1744121814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BkPzkuBUqwse7YVnqaD5dOUPiDumhrSnsCQ6NsORiCY=;
        b=dlAEN42XjmikS9Qd6qPXdYIZ+l4CMMcaxeEm5usshYkYMOAraSBK/DkVP6/bfqoI74
         QpzBCwIe6xevpvzAluE1wJMukLyLAi+xwefteaLWU0H2LiHrwVDv3xhFQuxE8OaqofwA
         upmcvBQONAiWnJTV03NM6tgNTwrugE7sHY3wsfweLpVHh/Ykg5s8F9T6Q+dWK+7o/HWH
         Nwften7209o4x6TQmqRCrROgEokmKYljsQxeBS9U5F6LZW/mz0jJq8wBNdQcTnfp2/Se
         WTLC0MoSMRrZSNaC9M0zQVZ/Yd4e+ibcqRCmQQ3D/Lm54phIERRWlTyuc32aQ/XHFh8Z
         dFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743517014; x=1744121814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BkPzkuBUqwse7YVnqaD5dOUPiDumhrSnsCQ6NsORiCY=;
        b=lmvZiPPu8jMaqShejEMTbajhCVjkfIjntsK1nYuBfTIxrKaJ02GbncyllknnuPbwBn
         MFawfeDlk89Ix0xFJB8ip4T/ngGIFhCm70AXhKnpa9TjZUWPkuqKLYdGx75w+xA2+Y6j
         xdyvQPraSATwtsHWY3BVdFpnO6/asqFgeHXZJRzjNd9xvyt0ChpgFyoyLfP5CNSrZ/CA
         DFV+zwNLzmlMIKLvU5wdQ0kpxJyN0pvy3vbuZ2n6VHtJDTENw6pfl9Tf3CRpYr4iymvm
         clnkfVJuvGT7yXBavmO7qs1XoPETDrFwYu95m+bqbY4/w8TJzBol5NbBwbznfdN3awhy
         zV4w==
X-Forwarded-Encrypted: i=1; AJvYcCWM9C5qymzIWbMsZduqam+IwPoUrZbHipry3/LrY+GMJy0zAroekpM2a9ASMTzYs093p3CtcKOlCrgc@vger.kernel.org
X-Gm-Message-State: AOJu0YyJg0tDnojfHoRPwG/0OfnJLmRmYGPMaX30af7yxU2Rsftkid9X
	5Piuu5TOv1X0Q0jeDFc2cfIkMKW+jwseugRYj//dzwSr1EbViYKM
X-Gm-Gg: ASbGncvrDfT0DziqsqnsR+EgDXy7sh/30IKC0FmtUdcyY3YH5+lsPDzwM2wiAo717dO
	6U+2CjCNw3Jr0GVO8Ujs/GfbMQ3XrXi+UrNoV6RY4ZjblLQqKQYQcyDckQXPTJjUFrQZHReZ1ED
	JJzT8MXEmKTSnG+Ba4bcUvyMe5crvKfGwuWF6NiC81sRfaymfujH1jzXzUvLRNRGi1dT+Za/Dxp
	SB2YvKqrwUgsj4z5qBucftQ6teC4bAr1HGkLl5Exumw6yYEV33jBmcwhjqSySQdreX1CV5F8Qjs
	BjPvx95Upt/G8MrmEsX27CLKwzANxq0+QOWQnLHaaLw=
X-Google-Smtp-Source: AGHT+IHwLg5Z+sfUOji84wDBvTlRn4VD/Tbmr9niGPotB8LTgU1v9NVwmM6ej0Zv+xVexVjsl8sZ/A==
X-Received: by 2002:a17:902:d48c:b0:224:122d:d2de with SMTP id d9443c01a7336-2292f95d9famr172572015ad.16.1743517013088;
        Tue, 01 Apr 2025 07:16:53 -0700 (PDT)
Received: from [0.0.0.0] ([156.226.172.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1df49esm88685915ad.188.2025.04.01.07.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 07:16:52 -0700 (PDT)
Message-ID: <dbfd11bb-9cde-4ec7-a9ef-0c28b7961419@gmail.com>
Date: Tue, 1 Apr 2025 22:16:51 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: mario.limonciello@amd.com, rafael@kernel.org,
 Xino JS1 Ni <nijs1@lenovo.com>, linux-acpi@vger.kernel.org,
 Mario Limonciello <superm1@kernel.org>
References: <20250331204442.1727618-1-superm1@kernel.org>
 <CAGwozwHyRiyVkX8rsc69gkALScWdtXNAvAGn7c2aEXW_qgdWsA@mail.gmail.com>
 <CAGwozwEiCXFDi73qAPSm2K9A8OZutE7dbjFfCmbUSAOTaz8SEA@mail.gmail.com>
 <50cc3227-93eb-4cb8-8151-23e52ca91f80@kernel.org>
 <CAGwozwH7r-7uELUB1fiftAf3ziU6irgW92qiHHNOpuJ-87=WJw@mail.gmail.com>
 <90d704dc-51ea-4c98-ba4a-f95460f65061@kernel.org>
 <CAGwozwEoCc_nRodt2=6R5K5UOzhW+5Gx1uLS3H3ON4ZS_12gBg@mail.gmail.com>
Content-Language: en-US
From: Xino Ni <phnjs211@gmail.com>
In-Reply-To: <CAGwozwEoCc_nRodt2=6R5K5UOzhW+5Gx1uLS3H3ON4ZS_12gBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/1/2025 5:01 PM, Antheas Kapenekakis wrote:
> Anyways, you got what my problem here was. You nacked and bikeshed
> this patch for 2 months, and that was after I did all the background
> research, testing and deployed it [1], so you could find the real
> cause, which I let you do as a _professional courtesy_. Then, out of a
> sudden you are the primary author on a patch I authored and you nacked
> and started testing after it was done [2].
> 
> I guess a nicer way of saying this is that you make it hard to
> collaborate on kernel development. When I bring up issues to you, do
> the background research, bisect, and general grunt work for them, you
> do a minor cleanup which is easy for you as a kernel developer, then
> strip the credit for them and I have to hunt you down to get some of
> it back. This is not a productive environment, I cannot work like
> this.
> 
> I think this is the 6th or 8th time this happened but this time it is
> particularly egregious, because you had me spend 20 hours debugging
> offshoots after my patch was already done in random directions trying
> to find a real cause, only to see me get dropped to a normal reported
> by, and that is after I told you off very harshly because of [2].
> Otherwise the reported-by might have been missing too.
> 
> In any case, there is no point in rehashing this over and over.
> Authorship in this series is mostly fine now, so it can go through.
> 
> And to avoid having this conversation again, there is another Legion
> Go S [3] patch you nacked and froze the testing for, so you could go
> on the manhunt for the real cause of this one. But it will probably be
> needed and you will find that as you get TDP controls going. So if you
> want me to prepare that in a timely manner, because that one actually
> needs rewriting to be posted, now is the time to say so.
> 
> Antheas
> 
> [1] https://github.com/bazzite-org/kernel-bazzite/releases/tag/6.12.12-201
> [2] https://gitlab.com/evlaV/linux-integration/-/
> commit/6c5a3a96be9b061f07bf9a1bcc33156c932ddf67
> [3] https://gitlab.freedesktop.org/drm/amd/-/issues/3929#note_2764760

Dear Antheas,

Thanks for all the amazing works and advice you have contributed to
Legion Go S not only in the kernel but also the HHD, I'm honored to have
you help on the product.

I'd say it's unfair to blame Mario for this patch submission because
it's actually my request to him and it's my failure on ODM management
that cannot fix these FW/EC/BIOS wake up issues, we have to submit the
patch to upstream as next kernel cycle begins.

Further more, I'm very grateful to the specific issue you have spend a
lot of personal time on it, you gave a very important guidance in issue
debugging and help us clarify the root cause.

As the project is the first time I work with the community, definitely I
have a long way to learn how to work together and manage the
development, so please forgive me on it.

B/R
Xino

