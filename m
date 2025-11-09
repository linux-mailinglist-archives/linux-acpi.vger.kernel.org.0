Return-Path: <linux-acpi+bounces-18703-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DD7C448DB
	for <lists+linux-acpi@lfdr.de>; Sun, 09 Nov 2025 23:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 937B13461EB
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Nov 2025 22:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A79A221282;
	Sun,  9 Nov 2025 22:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXuoY9EY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kUSlRpLG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAD71FC8
	for <linux-acpi@vger.kernel.org>; Sun,  9 Nov 2025 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762726585; cv=none; b=ByZYxy89DsgepYj+ylKg0eqS4W1xhTD6RkO5iy7fESPivoieZN8tYKHvf9IGKkUtQRa+KWBww6UgPpqdTtNieM+xwOsuZfUyzsyXBYIF6oNxREE8hUpB9ENP21EbC31OUPlkEZUOJQbLMZBPsjMG5WXlc6OnKiJ/Uy+XN31CrkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762726585; c=relaxed/simple;
	bh=/PuX+3jmsJjIndcgAVsSlPm0Emgx/Pv+nrKu4RAxmGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVt5Gmbmci0Lw+VjlzLk1JGvSEVagUODJyu9s2bxXp493FTc06enoISfJz1KtpuhehohI15upK8DHcC2YLZoGcXyZfv97l2D4ChxGdLfBYbdzbMSWJDCXU8IiWYnrHhKZ44Pk7eSCNXH7/nU8YJtzeO+ILoJiMRQM23p5Aiq8cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXuoY9EY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kUSlRpLG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762726582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uy3b83BPtCTZcruT6IGjn8K2xYi0joQB2DmZjVjxtN4=;
	b=KXuoY9EYhNeowIP61xt36RRkpfu6Jb7Tb+BWfsM1HbZWAG58ze72Onu3Wsa7qltGgVRtqe
	6Y6GnXJn2MSr38qtiAFtVucLfVIQ1K1nY3h4QrzlEPUGS4YPXVUXxABI2li4TFGO9tuSQq
	MioFErf3Zk6EvgbWg/Lw+Valnrski3o=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-n4rVyZ81PBafsyoil8zLkw-1; Sun, 09 Nov 2025 17:16:21 -0500
X-MC-Unique: n4rVyZ81PBafsyoil8zLkw-1
X-Mimecast-MFC-AGG-ID: n4rVyZ81PBafsyoil8zLkw_1762726580
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-297dde580c8so42387775ad.1
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2025 14:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762726580; x=1763331380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uy3b83BPtCTZcruT6IGjn8K2xYi0joQB2DmZjVjxtN4=;
        b=kUSlRpLG0/Vyo8tNKnsZ/lXkU7YhZvXIWk/zkdiXU+wFAfPTaQeHsBgI2ONqgfz4rF
         4bL9JR7SrD0Lk+V/aQ/myWaCOyQMg/1TT0Tui6pPXcD6RLsn92jYtfB+1RqupdOvrro4
         n6eddD0630jqdQVBgHET5GDpepvXXSgb/JGei4MilnghDl4IpGzizbg8i/PkZ4CEGGTF
         jeDqhq5n9oKVhCtl49qITj1Cf1Vh0GRaNHNgyfuJ86kpEy8XBYCCnYGtSm5yNfkuj1mh
         o/GAcFCQi+dhTzwZHVIZo3hgdUG6yPcbRgQBzcP7Hb5IPPPFmrGnLytddxHy7hu08Xi5
         pf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762726580; x=1763331380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uy3b83BPtCTZcruT6IGjn8K2xYi0joQB2DmZjVjxtN4=;
        b=RmOpHMTsaKiHPlXpU4wX8c95KWVv8vhcXw0MoEr/MmIkpj0dcrF+GW9yiOGULDa+Dr
         yzI1YXyeLbvD58HFh7QZirDQq74VSbWpwU1Cn4ZnmEtcyQkEfT+y699QrNJNDktxK32y
         ywA/9d+4o77Xs4i2x0JedRNi2c40ERuPQfrZXTvbAfkbF1ObeKEzoXx/53JFgZwTJWzA
         /NOum/UXBFW9SkX1PaXe9BflNfXdVi7tNwkrdme+tfoXCBqyv8McvOJ44qDihcouUnEs
         ph/og6Wwzy3LYVYLqU+qMNRPlWnmttJYVPtMLK5i7ERijkQ7XbjkL5S4OXGryv+HkWjK
         jP9A==
X-Forwarded-Encrypted: i=1; AJvYcCW7TDzHypPwiLbaOqDytI2wFBUiMn7iTqPRYgs0wDHT7aTag7CRraI0b1fEOMp92zAozlCNiYLIshfW@vger.kernel.org
X-Gm-Message-State: AOJu0YzTivAJGPymcHymhuTXEI69tZ2m5SCrtCJlc0wCNS3uM8ut62gr
	2sz5AimIPBBg0QIM53jArCOHmdrMIF/xVegu0bmJe0wUCj7GMl9YmpbXk191DiagcltqlosPRk7
	QfAPmtFNSMJvMtpv+C9mNa7q80nZKzu1glB+KvVDXPCzOODsW/tdDB6qk5y550vg=
X-Gm-Gg: ASbGnctIX0hZaQEvPbrSYCQY8ncVsktAOKgWwbnvgHSNRVUts/XDIiNmQIW5Bv1Mdl6
	g5IGk7+p6XO0dPv8BoLG5H/4Lh2vom7syfdFhEoed6oWxjn7NYas8sAcXB+YaMoIQEXG2Ma7sjW
	4Sl2HVxRCtozIesT6nhfZB6+ZAaEtwWlnt8XXLAqlNLt9tG0QI/bIYFJ5Tx7z+/nNDLqcAQ8eix
	bm8j71LmqWKsG4BWYB/T9VGIc96pt5RXpbFEglvEnK5vlbxP7y1MT/lhzJgT26LGphTXzW/LY40
	1NdBsvtjqF1DAFrpmnLbJM6YUtRSMlaT8mDlU7fen+1E2jG1uPwE9nwS+vMBHq71zNvJmt2kUbz
	Xdp/JPoqwfcgDVws/epFQj138mgsjd5kS0J1pYPo=
X-Received: by 2002:a17:903:94e:b0:264:70da:7a3b with SMTP id d9443c01a7336-297e570dd4bmr77735965ad.49.1762726580279;
        Sun, 09 Nov 2025 14:16:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcG19xyiPZhNYlQHBgksRNQWkm2IICqnjavOrSaWgOtjPu4QREcIcjuS/S8Nrkbqd+UHhwHA==
X-Received: by 2002:a17:903:94e:b0:264:70da:7a3b with SMTP id d9443c01a7336-297e570dd4bmr77735785ad.49.1762726580003;
        Sun, 09 Nov 2025 14:16:20 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c93e5dsm125460015ad.81.2025.11.09.14.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 14:16:16 -0800 (PST)
Message-ID: <3e551b14-fab7-49f9-8806-6d14a4229dd7@redhat.com>
Date: Mon, 10 Nov 2025 08:16:01 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/33] arm_mpam: Extend reset logic to allow devices to be
 reset any time
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
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-21-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-21-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> cpuhp callbacks aren't the only time the MSC configuration may need to
> be reset. Resctrl has an API call to reset a class.
> If an MPAM error interrupt arrives it indicates the driver has
> misprogrammed an MSC. The safest thing to do is reset all the MSCs
> and disable MPAM.
> 
> Add a helper to reset RIS via their class. Call this from mpam_disable(),
> which can be scheduled from the error interrupt handler.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
>   drivers/resctrl/mpam_devices.c | 57 ++++++++++++++++++++++++++++++++--
>   1 file changed, 54 insertions(+), 3 deletions(-)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>


