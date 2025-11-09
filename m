Return-Path: <linux-acpi+bounces-18715-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C598C44A02
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 00:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B6A3AF022
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Nov 2025 23:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7696272810;
	Sun,  9 Nov 2025 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FErSx9sP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nNfzWD2w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1464C23BD1B
	for <linux-acpi@vger.kernel.org>; Sun,  9 Nov 2025 23:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762730393; cv=none; b=ms9qb6IEZEa/eKO4DI2cJkW+swTycekx5Kq/+gXYDDRZQn58iWJkcRbIt1MNP7XActL0wIgYk7FKNdAEYUyWQyFo31BEkedD1b/XSKekjN1/ErpKShWXgDTYZrewc8WmBb5KDZ+oRt0rwWrhobzmEDK0lMRaBEvXr1c8ng+t9BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762730393; c=relaxed/simple;
	bh=lrytaMAcYx3ZKACpSPuLLmlxwodrevAZ0NMZJ+T9g28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/6j/Zq+ATaMFqCKf7Ole3PaYgaKVwn9OSK3LAOx3DRbM8cuZ3gTYODfcOFCxeOWQ9blv8FdOQxn2xLnU08gdkUoGYJSgUlGmaQJff4Xqr11mLU6FSTH52K4fp6sfBPe/Huqi05xc8uJ4yiFgFDWiK2ZwqPm9HhDFffkVmEo/0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FErSx9sP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nNfzWD2w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762730391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dubJJZUeDuyLgjxuOinZfNrgxD8y2GPrhW+uof5Koyw=;
	b=FErSx9sPGypUaeuMI0f/VUg4KFa2c+yfU+UrWGcvfu+VWRKRMjLdCDshJmUe6M4q1PXk53
	Mbh/CvJR1i3zUSULyn0lG3vhyjYKwpvKCpO52baPiwy8YBME4lWqhleYGOPM9tkRT9QwR9
	wH7wIFBdolReZHgFAKn7d6rIudG8+Rg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-UpBRpMr3Mb2qgng0Oe5W0w-1; Sun, 09 Nov 2025 18:19:47 -0500
X-MC-Unique: UpBRpMr3Mb2qgng0Oe5W0w-1
X-Mimecast-MFC-AGG-ID: UpBRpMr3Mb2qgng0Oe5W0w_1762730387
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ba795c4d4a2so1678550a12.3
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2025 15:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762730387; x=1763335187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dubJJZUeDuyLgjxuOinZfNrgxD8y2GPrhW+uof5Koyw=;
        b=nNfzWD2wzfE2taALxqkz/USJKMeP5D1l7KhVHzUAn99dITFvoWZef9X7BYwbs53URN
         rM91rzVkbkoQy018ijc5LQ9M3oQarF2HNwKMJoTNm1ZhdEBMZxc0jItToPLLGiXIWcOp
         6Yp7BlaSM1IZveUJuvYBQwW3A3JwHD9i4lFRl/wsQCnzCI4D6FeaIkF/g9ntSCcPMwk8
         nTNPEiWakcJgg6vrYyWNOkO6gCcdxUJAo7swqMmWe7NZIMkuvNK4MbR2DEbfEttdTPWN
         Fe92r8EOjSevkgkBuFwjB7H03sYD8bFWtJQyk9oW2kuggdfSmqKzl3LSXiMMTsl2eqNx
         327A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762730387; x=1763335187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dubJJZUeDuyLgjxuOinZfNrgxD8y2GPrhW+uof5Koyw=;
        b=NanHHxhRgJwVyYCiKD20/xk3voTUGuqNAxYvi70caCJhwb5frgkJ/FD8x6BEEKf80G
         m6iY4G+rB0mn3xwWsMeL/TsiodGRw0YudMt1Ll7SGlAQOB/o1sTtPsiwAIGeAt4QS0bK
         p725eMZETCIw75vyuioMA9TujA4ft4t7GBk47GG3uyHsOFY2P1soOqBAvPIAVDrGlqVK
         DBl0xNCUBHv3KnC+H9JcKnqaNeX0I734Xqaq0I3jgnQMIF3tsnM92GX8EaoAMkDO3qip
         qn8FufTvcLodXFKHnAsn6m9GhuT20evC/Z/biE9Z+8BJ3Sth3bWjd9+/fmbhc+O6hcWK
         G25g==
X-Forwarded-Encrypted: i=1; AJvYcCWAWVY5yeJXmSRfLPCUAovmF57SDYmPhYHEeMJZ+JF0Kf8OuVltgrIouAMfArLMyv85zhMESp8AXxZG@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbk82sPV0LbWQwE60O2XKhy1elMqG1qjtx10CWVyN5cKA9Z9Jx
	IUohzfTNHg/kkYD+5yiZzjRGRdQFfolgg0uQhAaw7B7HF4ePPzkKVDRzMTejGMM4Pdwzf217OOF
	Un/u5kCyuG79fjxCLzupc15gd8tvMwVxr/kdm97hnI5N7Nj2rziwlpWH9DltY3nk=
X-Gm-Gg: ASbGncv+41+/S4Vi/fSHDGqtJC7tWiyi3T5sTYpvnP2hfO1efnwTJ+casJ3yoZnFYHy
	2OrISTG8cuiB53s4EgCICdKyj8kvAfYaSgYKog1dkIoNzV6s7KikIQglBh1c8ebFVZOpPj7Gm2z
	8ErSebmX3CZW2lh4sy9mHEYhZPNCnj30GIVKrRBKUnJrcsTXZZM77TG/AFmtVCeorgKaGVGmunt
	Idgn/WwHxS+BUu0npbFdqlyqXNElBspXk0zp0BpbaTpz+HjpnKhmNxaQrwpI8hEU+trh6RkfTqz
	Nmc69xWY/TcIBOMuDKxQ8NmyLdP245kD03GOdQqhQmRNk3XbIAJSa/2jHnR7qNDFBQgfc7t8OFz
	kBAH3LlBrMo3Nwpu+JwakgHQmDqtvuTRhwntco00=
X-Received: by 2002:a17:90a:e18b:b0:340:ad5e:cd with SMTP id 98e67ed59e1d1-3436cb73cc8mr6923409a91.5.1762730386880;
        Sun, 09 Nov 2025 15:19:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLmBsEtvmrbu2EisKkS/8V7PL4jymEDPy9iS1fiQDMzqvfm6s80YMHDPtL+IUqN7rphhGZ3A==
X-Received: by 2002:a17:90a:e18b:b0:340:ad5e:cd with SMTP id 98e67ed59e1d1-3436cb73cc8mr6923390a91.5.1762730386503;
        Sun, 09 Nov 2025 15:19:46 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68ce9e9sm15157570a91.9.2025.11.09.15.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 15:19:45 -0800 (PST)
Message-ID: <f7947bab-46de-41e8-8e4e-f18f163b9e5f@redhat.com>
Date: Mon, 10 Nov 2025 09:19:33 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/33] arm_mpam: Add kunit test for bitmap reset
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-33-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-33-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> The bitmap reset code has been a source of bugs. Add a unit test.
> 
> This currently has to be built in, as the rest of the driver is
> builtin.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
>   drivers/resctrl/Kconfig             |  9 ++++
>   drivers/resctrl/mpam_devices.c      |  4 ++
>   drivers/resctrl/test_mpam_devices.c | 69 +++++++++++++++++++++++++++++
>   3 files changed, 82 insertions(+)
>   create mode 100644 drivers/resctrl/test_mpam_devices.c
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


