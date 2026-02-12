Return-Path: <linux-acpi+bounces-20958-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFVgAzndjWnE8AAAu9opvQ
	(envelope-from <linux-acpi+bounces-20958-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 15:01:29 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3B812E0B5
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 15:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2432303DF47
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 14:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0B72F0C68;
	Thu, 12 Feb 2026 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8T00ao1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E92E1AA7A6
	for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770904840; cv=none; b=Xuovmyfc4qsYf7+tPCi7HlRYN0FxYfTk//d6sB9FrNFH4mVNmyhRBEPY7BcBMIvE9mtSEPhxH/Hp8ydlRl1Ns980hLrsH3mWZZM2dHjnZYrYcBmrmCjRzzpUSW/Rmf1sygftzf8xGBeV2V7kHaquLQfn5Tsk+pXdreN1ldKdqWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770904840; c=relaxed/simple;
	bh=EMslkeK4yt1/2dVDmbcC70GgkmYYINeF79GnZRnXG+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AaMkePGq9+UH2dAdau8TbtrPDX6sWDkWgRUftpJFFqIPUMpURAbQEHOkvjz1J7LJHhKitsHVNf1+nvFqmqJdtjuW3podpvo5U5Vc4uwX48YTEunra5Saniyq8AhWLKV0NxbHUj+ZQbH/hfR+ExdEi6+Mlx0VLGktCZsefq2XHOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8T00ao1; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ba6aa57d5fso4882347eec.1
        for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 06:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770904838; x=1771509638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ylimFk0+B20t6OX8XGGamXW0xE6sIJivZp3QqF6GFLA=;
        b=e8T00ao1oJOOGKAdvqDCZ2DRgftfp0KPX692xEUbVNY3t2KEvBPCpkPtPjByrJAgC8
         jBJK9d9jE6rfa8oxNmwx0oSz1190UvRea/JpvenAELlcd5ECfcVRruBwZ5uhL2uEEmMO
         iHN0uQf1hAQwD73d0HMbYo/4KouO4IaaaP5oUjHtThMvCoGM9QazMMZKELuL9Ex/90qZ
         DbN3zjdSo10X6hBFI/hU99BU5sGcy3z0QUIsX55iyB5tRR25n8Tk6w2TVl6bqIQrP6oF
         9E89B/D2NVM8BU3AbpH1GzY/5izuSO+QIuB980TqfAplEo1hQknAcS5aRlZ6+9WH4rKH
         45Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770904838; x=1771509638;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylimFk0+B20t6OX8XGGamXW0xE6sIJivZp3QqF6GFLA=;
        b=mJBtpF0bxAbzdvSa82VPJ4F7uGWmA6LHj506zuSAhz98LqoVpwTstqRrMpJfQMlFSh
         mCQdHPui+QF8tfi3cVEcBTls5OjZAjCdUv+7A6hWH+fAO1yyVzrRk3KlMYiZwzJddMgx
         XrRKs9oQhJ6xtq+Q17kSL/XYgmG8KWcfFsU3lAOPuxgsPxFqzl90rS2AY4MDxiUwPm/b
         P2YB5rIldCukHoN01n2iKlpgOuJdQ5LgmWtGaRUbXs1VEv6e7GE0iJaI39T+MDdg8ius
         42a8F459mldLJsD7P5vk5sqNxT1DHutI6XWhIMCtC9KInLyzmJcGEt3vb7Njp7uegq6/
         cLdA==
X-Forwarded-Encrypted: i=1; AJvYcCUx687F0PBYEQQcLwlGAI2YntfvYkDttFP2iiZ1IbVSrmu2QIoBMVwdpA6crq2kK3bYREPt6zWn3e3z@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2nJHYpwXGoQgzW79dLaV//2f42c+TH81eFul/YKpJCg4eU4bs
	F0f3ihRtYyl4JK3LxLzqd43LnuUpCmyFb74RYlpyS/snDvQUxGS78mRp
X-Gm-Gg: AZuq6aLyNwKqC3qsAlqIPW53xfzS89lwneMM7z7hfH6LisiZDqBssjpEr/RD6eWd+4h
	vaIE+tARrzNTRz9/XxJeZAM0SjIJ0ERUeG4bC4G73xbcfdG4ohVN/a5K8VGhoAK+vZQ6JBVKn8i
	Zb5FxONZccK08SRTMfOOaU5PzdLGO5KSpmWf1MHcofq8Jvo7CXvhbE1ilRhsPDVMbKEBVBceEDa
	BdAgOGMS9QyqGPOVr5Ck3rPccvNW2GCw9F4uHomOmhDwf8BhoKnTweGgdwy3PhgIZupLa98qHVU
	PvRO8BI65tffskATMXpFulR0bnPvT+J+oRxDZxpADGmn8rl18givSwYVK33aVV/BHCDJMan7+yv
	9oFYf0U1bib9cba7LI8PYUDntneo7nGd2/qvxC2vUTjY82sTzdqcv1C9VHZoq/U7f+njo6o/X9o
	Tnvx5sUNgDz9dobJ5FjXSzdPIxUdUPD5eT5uvJmWKddbAkUAJeIx1r7Ik0/W/g8Bphuf7EC2zZ
X-Received: by 2002:a05:7300:a14c:b0:2b7:95d5:3a32 with SMTP id 5a478bee46e88-2baa7f7c7e5mr1192493eec.1.1770904838009;
        Thu, 12 Feb 2026 06:00:38 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcd00d2sm3919413eec.20.2026.02.12.06.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 06:00:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <975b4e7a-e007-4710-9048-b975cd66780d@roeck-us.net>
Date: Thu, 12 Feb 2026 06:00:34 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Revert "ipmi:si: Gracefully handle if the BMC is
 non-functional"
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Corey Minyard <corey@minyard.net>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 openipmi-developer@lists.sourceforge.net, regressions@lists.linux.dev,
 Igor Raits <igor@gooddata.com>, linux-hwmon@vger.kernel.org
References: <10802540.nUPlyArG6x@rafael.j.wysocki>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <10802540.nUPlyArG6x@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-20958-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,roeck-us.net:mid,roeck-us.net:email]
X-Rspamd-Queue-Id: 5D3B812E0B5
X-Rspamd-Action: no action

On 2/12/26 05:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Revert commit bc3a9d217755 ("ipmi:si: Gracefully handle if the BMC is
> non-functional") that attempted to improve the handling of the cases
> in which the BMC was not responsive, but did not succeed.
> 
> Instead, it introduced a regression causing AML in ACPI tables that use
> IMPI operation regions to block indefinitely on the tx_msg->tx_complete
> completion in acpi_ipmi_space_handler(), which may affect ACPI control
> methods on any system where IPMI is involved resulting in various types
> of breakage that is not straightforward to diagnose.
> 
> For example, on the system where the regression was first observed, it
> caused sysfs accesses to attributes exposed by the acpi_power_meter
> driver to block because they involved AML evaluation which is not
> super-easy to connect to IPMI.
> 
> This is a nasty and rather urgent problem with no viable fix in sight.
> 
> Note that AI was involved in diagnosing it, but didn't help much.
> 
> Fixes: bc3a9d217755 ("ipmi:si: Gracefully handle if the BMC is non-functional")
> Closes: https://lore.kernel.org/linux-acpi/CAK8fFZ6Vi4xayvdKh-_eLi-nDNMLuEoMsvwEnb33QqnwS7o4BA@mail.gmail.com/
> Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
> Tested-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>


