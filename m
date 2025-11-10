Return-Path: <linux-acpi+bounces-18718-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F7EC44B43
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 02:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E31C3B045A
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 01:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C8C1FF1B5;
	Mon, 10 Nov 2025 01:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZ0wADb7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q2uYHlgQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A291FC0ED
	for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2025 01:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762736648; cv=none; b=K5moGPxXlslJcz608lv4f25ZtXSZ4ZCoZ+PA4GZPqB3E9U+jEHzU5oeayIrP4mu8H8iqajhalRlP374CDBY88AolWOLZwEncsOQ/5uosu0b2JubrYP1ZtXpAVUisxmG5MPgtmk/BB4NoUSGmZinAmlO+dI+qR18QA4tWKA/ROcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762736648; c=relaxed/simple;
	bh=XR/ZHpAPBxjFWVCkYUHWLlXK9i6lghmC6dcE5F6S+nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4o50R5koFPFaHacqjbrVa+poGMsuS2be1+DmP0Jb0yu17B8aT8sShNwFO9uWBdixNdETZGUIQVO64fhX4hgJ0a2ww1rF6kWGYjnYBdu3xS9aoCJ9spzVjtuVXNxOIdoC5IaarcOnJAiKOwuHKzctFyoKs+X24blgnSZ1veGLbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZ0wADb7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q2uYHlgQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762736646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=leua78RlXfOm5yDLa55yyb90IYdYDP2Cb4NE7P74U7E=;
	b=BZ0wADb7+yYbVI/TipXIdt3cjv7Y1BDqRtsqbZGfOYMe/kAF4g5/kv7oG0rwAXbHgjveuV
	lS+lV20As+TmKI8/G7wCumtT42Uywa8K8SjyZmsOMieOrjQqQUNziUL7nNJtvQ2Sn1PX/t
	OWreLfOW3Y0yvvJbXZL8yLLgZdilEM4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-ynaIyj11MEqR-OQ7Wj2iUA-1; Sun, 09 Nov 2025 20:04:04 -0500
X-MC-Unique: ynaIyj11MEqR-OQ7Wj2iUA-1
X-Mimecast-MFC-AGG-ID: ynaIyj11MEqR-OQ7Wj2iUA_1762736644
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6097ca315bso6074578a12.3
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2025 17:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762736644; x=1763341444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=leua78RlXfOm5yDLa55yyb90IYdYDP2Cb4NE7P74U7E=;
        b=q2uYHlgQ/F3KexbvsCUa0guEEHFW0AnCMKhDshT3K4JsvCzhxudTd+xgexNyoMbH72
         Fn0IDmadexeSO+lOP6wHQAUatAtL4+BSVDsSTuJj9jFYU9ORVjJ+cLVO68AegFAcdYMU
         I1u2qC8QpQ0kJ1nC0vX/hZvAtM/Ow0SD80hyDYBWEumfwlDUiaKtMFRxWrBX7gLDR2iF
         oHrEo+0nyyQLuoXVrnksfYBfwnVvODz9lnaawIuLi+NtZWRkpjPeJmxEGcr2Hjcj0Dv+
         M8H26i2X4adnAft9jJGkK9B0tfbJFyHayB8si9iEaQprbppzb6/KgTQ2Epj6ovIPFN7g
         ZV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762736644; x=1763341444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=leua78RlXfOm5yDLa55yyb90IYdYDP2Cb4NE7P74U7E=;
        b=alOAqGZJpoDleRI4YE1DpxN0n9IP8/9xvJGM25aWKqZX3Ne+9+Cuvlw0C5G6voQBCe
         ypgJCj9EQkRz1AAjVPEHP5e99858eb2zjLaXy0IDZLk5lSs5r6n/MxNL/vEVygWCkzE8
         N6e1rJC52Y80IfwlT/WG+i21Ut9Cy+GqmCmfPyWShL3xl/V8Kdi85AAr0vRhh+cd1l+8
         ISr87bIOzZbQMbpur2z+4ouHUP/DY2PzX95dcYR7rdn+o/F3S5tdBaeUHRLhfmh+Gaxg
         JS7VKWu9Bwzz1Qi96AfbyfMGH9AEahuQMPv1/dGdpEP5ucUwdOggpGlLrVe6cmBGgdcZ
         gOUA==
X-Forwarded-Encrypted: i=1; AJvYcCVkNO2pgPKmgo1ba03m8dFWFl1WlWavSPZ2fjajB4QwpR4ZZLD3SqVidEdL/f6URx+46NiuN/5XmjPa@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ+pIiyHTjHn+eLZVzprByGZnwv7W24wTxeheelLNMoY4Ooqd/
	fhwnJ8QRqdZJCYP2pB5z/2JfB8LZhM4Gjn9z0Bvv8EVZs3jf4n2xHjb0P/tbmyl9kVwGWXIcx65
	sNja02rYyaFGBhKsV656nkHD5lg5qpoS0EEQr+elFhWpDaq1CZWSflUxaB+Gs3aM=
X-Gm-Gg: ASbGncsK8/EpvTuj4BeT58tZ74/OmQQpDxBxhrIJ/0nAvVNJqZlIKPlpgSOuvN7m2oI
	Vt2P0QyoOP7vTW2zN2yeQxciwe3Eoq10IZ1KsGei0PiwpoE4l6QxUTCh9NNCpdU+4AnZoWpsVWb
	n+hKj1hMpAw5In/iwgmAcq3rFhQ58VabTkAkRg0J9ymim3D1npR7WrugoCvFaHqzsxVS1WkSQ/y
	WqNKG5VvpeJ/R153K79ymMKDP5ehAlWF8NvzzA+43NpCOno9qfVwEo1xxDigCbIv4xRKMGClArk
	6006TIbzetQk5dKY4M+XXEr+S9XI+skuL/aHNzE6G6fdgvZguqs6NiUT7yP3zwQRh03VISOb5BQ
	N6IadNN+P/PFy09ORqHIfDX5K1EnzffeyH+Tfe4Q=
X-Received: by 2002:a17:903:2f8e:b0:296:4d61:6cdb with SMTP id d9443c01a7336-297e5655113mr79634265ad.27.1762736643569;
        Sun, 09 Nov 2025 17:04:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaEQ8lrhTvJ73whBKPu8fioJhN253YclztyjeBunZlQDD4VtJSfb529w7R65ux2cszJp0SoQ==
X-Received: by 2002:a17:903:2f8e:b0:296:4d61:6cdb with SMTP id d9443c01a7336-297e5655113mr79633775ad.27.1762736643128;
        Sun, 09 Nov 2025 17:04:03 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5e3c5sm126117355ad.43.2025.11.09.17.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 17:04:02 -0800 (PST)
Message-ID: <7e58eb4a-f8e4-41ea-a2fd-742e632c7deb@redhat.com>
Date: Mon, 10 Nov 2025 11:03:51 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/33] ACPI: Define acpi_put_table cleanup handler and
 acpi_get_table_ret() helper
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
 <20251107123450.664001-9-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-9-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> Define a cleanup helper for use with __free to release the acpi table when
> the pointer goes out of scope. Also, introduce the helper
> acpi_get_table_ret() to simplify a commonly used pattern involving
> acpi_get_table().
> 
> These are first used in a subsequent commit.
> 
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
>   include/linux/acpi.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


