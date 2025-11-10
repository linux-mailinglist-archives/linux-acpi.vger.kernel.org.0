Return-Path: <linux-acpi+bounces-18719-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCCEC44B4F
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 02:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 190FB4E2B7B
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 01:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94641F3B87;
	Mon, 10 Nov 2025 01:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqMx8119";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bU+kZhfJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F94F1EEA31
	for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2025 01:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762736776; cv=none; b=YyUvs6ny9Tlo6PU7hneayfHZBED4AisECOeFhKkxgQCG8pOpoefKGqk9+Z7wNdYKjB0bnj74E7aFYKz6NUA/scdb7QAD3zta6laecrJqDoaJIM1nrFS4BKlkaaPPrk1aZfMhFCK8pkcDGjTbcOZ5hgtoEh4tLk+Fvq07U8xivaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762736776; c=relaxed/simple;
	bh=aOlrI3w1cNPvUYCImrIb2JafRvNQMyXUFJFDnijJcxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bd4S86Afy4meq7H7ZZDaEw9EhMmiyu4gXaUD1wLNQRT0N4XHWlfsbXeNkPBZA/6MA45HYL5s4OrMdEZsuAdXczW4xJ+V3CXfAL663a/d0v0xZkg5MLttneq6g0HU8c94y6fqaLeuOqrIv0sAbdtn2fwtf7cBnh9l6gwRbUvDSwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqMx8119; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bU+kZhfJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762736774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYWyKNlYaxtpet7IUj4DYu+DKPKVpLXZerwfq1sZgQw=;
	b=eqMx8119D2qUt4tv8vc39CvTiCok6SK77Tnzk45Xqnb6TjT+M5oQnwOpDNg9ZBk5DoHqAr
	2HlkX0fbsaEchOqArBaro+J1ZY0h5O5xCsjtvNCNDLk0sX/TG4/RajPW50ujr2JfHmJF3t
	LwYb9U/zy+4m4bQNYTrbLQ7PvsnIBMk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-YwxdtAZyNMOymBRNgQPxJQ-1; Sun, 09 Nov 2025 20:06:12 -0500
X-MC-Unique: YwxdtAZyNMOymBRNgQPxJQ-1
X-Mimecast-MFC-AGG-ID: YwxdtAZyNMOymBRNgQPxJQ_1762736772
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297f7ca634bso18285395ad.2
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2025 17:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762736772; x=1763341572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cYWyKNlYaxtpet7IUj4DYu+DKPKVpLXZerwfq1sZgQw=;
        b=bU+kZhfJTNx6C9Zkndf+tWk6trT3xDFUwEa/1SK4IxG+Kj6RLHeo19xHZ2QDjkWona
         s89u4Ue/eGPCOn7emg/tS6/pqC4ImsBKzuQO0tmG2RGZLEkX8fm21j3Rookiur0oE1Xd
         XaaOf7pzPC6mcb+WEH5t9aLXgGiiMHNL2C2nV2RrqAxitKO+vnCFJI6nIzMr7hr07cVS
         u2m/DJu/CTz9meFBQszcYOeXgp+dK0646xz09QZ5D/ufoeu+9kqcPD/RXHAPkPpdTRn9
         hPuPNAJyB0pO2MecniY6gNteAESgZemiaKKTb4XXOOJt1tqA9WjtaI4OdqOHB6gjMhnW
         kFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762736772; x=1763341572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYWyKNlYaxtpet7IUj4DYu+DKPKVpLXZerwfq1sZgQw=;
        b=OCu//4CFE14bv2mUObUe7lLHoGlnEjYkFoesMgN9dkXhj5FyhXuzrXaVNuXwNdo+ks
         iL3hEBOrswmsE95P6YuSmpGbVlyVr1zFdGLdEdCgOIpmqX9gW8itr3t2BaaBTe++ytD9
         UDf6LxtstY3UN3aVGKrP5rOGV/YoFHG+eMbW3F0o8V3+UupXIMyyWv0cBC0EWjHcLdlh
         fEUTZsIf8uigV/V0iEXVCz6PU5J0I9JOEjilp2dOvclgF1NrNW+LxE9hl2ebka+3clVx
         RzD5lBOdci91Q0USrUp+Y5aPiAhUEuTErocvQBwORUUFCcsKlavkG6p3FBBwYlkhaTQK
         Bn9w==
X-Forwarded-Encrypted: i=1; AJvYcCUmCzESTsXeFBNxdNdHBuaIG4yDggCVLYLsL0rMZXnun+b7vYm4uLgKD3bchT5oxx1tJBCJzyAfJgz2@vger.kernel.org
X-Gm-Message-State: AOJu0YxwByQPYzpbEji6WcjnN77ffpP3r0r5XY8eUvUHYOE61gCc6H8c
	CSfOYSZ1uG7V+KMBlHc9XVx8ZiWvEJvDQkkhv5MbyqvqoPYlQZO4o6N5u4g4bDBhVVt8swT8FE1
	F464uj0ReUZghG3mh99B4dAohXc7ikiMldyoQaT567HUnqlqBL6zu/Xmds881q5Y=
X-Gm-Gg: ASbGncsZCP9F12y5FdcAimf+zekvzc5710mSyjZmRd71NxuKKA9uc1dQchMWQ0w2h93
	FFCzHZLWnZg4pCf4JxoKRzH0Azfgmvumbaw1UHyA/+PbdY2WJjkKWQ+d5N4EVS34lNS/JHOlu7i
	abm4QoIOk5o++GiQ2T/2HRhvQH1zCrorLmgIneFGMPrCtfzJdDvQWJlD3TO7gp2KAgRuE6hK+az
	Wew0UM+0TRobN9wxous35ib90vxo+G89QVNDEmBvM3MfWYY3WbfQIeLSWzBJnTaV39126RvqqxF
	3sbszsJQPjSWR9LCxAGUAPzXuQ/1KKG/cPiZPzERmKsAMIyRLycz8U3JeTqdTtQb9GACSlO6KVW
	UazKXXlkxvPA5nOJIdNbHFfVQgD4F95wL84+vclw=
X-Received: by 2002:a17:903:1b10:b0:298:2e7a:3c47 with SMTP id d9443c01a7336-2982e7a3d03mr3138555ad.42.1762736771838;
        Sun, 09 Nov 2025 17:06:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFF0CFiEoJ6ONU17kU1QFkRvQ5VxAZyJkrEh15FlCVoOKf8DubdfC/6/KNrhSF5I5E8PZmNrQ==
X-Received: by 2002:a17:903:1b10:b0:298:2e7a:3c47 with SMTP id d9443c01a7336-2982e7a3d03mr3138115ad.42.1762736771483;
        Sun, 09 Nov 2025 17:06:11 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297d6859a92sm75549945ad.88.2025.11.09.17.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 17:06:10 -0800 (PST)
Message-ID: <37725bd8-768e-4b7a-b202-9068f5e14257@redhat.com>
Date: Mon, 10 Nov 2025 11:05:57 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] arm_mpam: Add basic mpam driver
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
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-1-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
[...]

> 
> This series is based on v6.18-rc4, and can be retrieved from:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/driver/v4
> 

Run booting and kunit test on NVidia's grace-hopper machine. The result looks good.

Tested-by: Gavin Shan <gshan@redhat.com>

Thanks,
Gavin


