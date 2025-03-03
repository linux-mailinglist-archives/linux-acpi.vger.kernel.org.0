Return-Path: <linux-acpi+bounces-11727-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220E7A4BFF6
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 13:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F3816EC6F
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 12:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539CA20E316;
	Mon,  3 Mar 2025 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/UAcHqw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC4F20DD4E;
	Mon,  3 Mar 2025 12:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004016; cv=none; b=Q2XTAr5drXtnNIpkpRk6s0Dl8b/eXMOf2+PM/JJHaCtZM9HFexQlQFUp1688n7dDS5429Jonpciv6eMjVcT6DkJ3aBDhGIlZyaaMYW6IgMGrdVJBM0CGM+ahaFDwT60lvUo8ggNxG2V7+sFVPBBlOYmKg2SBhwGebkQ9Bjb6uhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004016; c=relaxed/simple;
	bh=67zi3moPbtJ00/7I6KgI37WCfQcSyOl+ZoHddiamufc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uvg11cMp7DKwd5ysjkCsVFD6lypUqMXP7oYGCepqfTMCDcj+O6n2lyvxxIr02K09BFVtc3qGoDko/0LnsAlQa/nylAJOYUw6xUYsHNs0VdSsfhGd0kYORO8e6rwBZ1UXjNWtnnRN/JJBPHJwPWXggsO8BpQ8XDD8nCwJ9lEYjkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/UAcHqw; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30ba563a6d1so19299061fa.1;
        Mon, 03 Mar 2025 04:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741004013; x=1741608813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4I10pqhpXBKjcK+lwxIKgzV5wGxXaBJXL3xG7GMPSLE=;
        b=l/UAcHqwR/lD/xI9zlb9AX5ojh2Ti0kdrkOXAZriXC0+9AccFEvO0t0lGZxXPDFAb3
         ftrux6HubrD2TDz+ECulNS6wG3oaLSX+VTC/R1mEcelm+695k2M2peXw/BlUUSmF7xED
         /tJ141bpu8/dMqhgrwvewykHqYuCxd20UmMrTsJmoYovkUmhAWJpfYOrgmfNEs+gEmhr
         1HE2JcBKY2zU0R2KqwVl9/solBwSneorHNzm8SvdZtN+LL1xGbu0zSO7ewOfBQPu28tZ
         tjhG9xKsPoztMgb5KvLnZhkkWLZ0YvXGW6Itv+V5kgHG1Spi/9wudh9Jheke3mptMAcl
         +pKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741004013; x=1741608813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4I10pqhpXBKjcK+lwxIKgzV5wGxXaBJXL3xG7GMPSLE=;
        b=V/ZLlhlbFuFHxwd0VvmrttGT6u/oVz/dO6Id0FuN2GyQo22v8OWOQ2kBY70l1ILvjZ
         ZYnakxEGx9IXRj8TpSgBbLq3vzX/18c7dXyXbOKwT8Nl6+FMJfh884ucC6SUzEEcGCde
         lphVWNXoduv7X+H86+H2+Z0mNRHdaM56zxnk3mX7+Yt2a0F19uWjmh+8dZnlgPzqyFNQ
         SIFmypQHGUx7lH4EEVp2oPgwBoOQO7eQR6rFaFqNauOCqzDktU1Gzp+W4vsAeLWLO/2d
         2hcAjfBdLmDqtbYtGvH7kjxaFs6+OMnDad2i9sv7FqagBOVRwWU7kD1q6aSdYQoE/W2i
         3DWw==
X-Forwarded-Encrypted: i=1; AJvYcCWMSdIM9D/KhmU3M64QviVGyjqxZAMdhq0KVOU5LPjrHcsiT+TdWVigFXxEdpTG8Edpk6skN0tf@vger.kernel.org, AJvYcCXQ6XGhBnfub9CP5KmFAIIBjyH+9ie9f2fZlnQcdGY72522wNyOQYN2I/7ZZP2UxTSWkekHrxwWaVbJv6uu@vger.kernel.org, AJvYcCXlUQpdWRULDjI0dL4BPHdATy7t98Uz0Xvlon3ve1aGixH4iZR8xIYrRlBP5sq/GLLFiqsxQppPKbsJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzUKMdhOkZaeaAZKZRD1SBCdpRFUI3uqFImN1IL+SIOBihpc3Gx
	4bu1rlPDjfHq0oqRU0Rt0dTNP9WGcyp0htwqOxstJsnZXByzylOr
X-Gm-Gg: ASbGncssOikvky6xxZA65SMd62I7CbY27uEV2Ln4XBkvRGE9OkhvpbS9NIkwOYojUBE
	mJc9iD/rwnYUCSp/sd5EjuENHOqlfrwI11lx7vqEmeSBw6T2bkM7QyUF/+MvW/ApiQK761Jd6FB
	XCqC0BE/dzlAJi6LZduY1F1Wgfts/1q5/DEMQQHhpyuNrJMKJoOMdF0jMpZY/A5EaouMh4OBsVQ
	5Js1bTFEeBW3X5oqmPinlpv4gwxcQPbtuwLUD3vkTV+bUukfJLy5Spl28INAXlRjSwakdW9JvIe
	P+KY7iWv+SkYGxNsaXRg3kVXSFEqrgJBj/weouxvh6GPWmPXbjq5/j+ePQDyk55DtWFfZf6HBUu
	kkbcJbjfcqrJwMpnzY1Ou
X-Google-Smtp-Source: AGHT+IHgUTPP7a3wfBba3HmV4E8EIQMEL1aA+9ZOmIbLBKKMxMzPxezWgUWnkJNajqEM38nxec+/Vw==
X-Received: by 2002:a05:6512:e8b:b0:546:1fd8:3876 with SMTP id 2adb3069b0e04-549432de15dmr6348652e87.14.1741004012425;
        Mon, 03 Mar 2025 04:13:32 -0800 (PST)
Received: from [192.168.42.63] (mobile-access-2e8451-125.dhcp.inet.fi. [46.132.81.125])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495d12b85bsm583134e87.234.2025.03.03.04.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 04:13:31 -0800 (PST)
Message-ID: <aacffceb-e9e8-412a-a624-568e6b10d586@gmail.com>
Date: Mon, 3 Mar 2025 14:13:30 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v5 10/10] net: gianfar: Use
 device_get_child_node_count_named()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <cover.1740993491.git.mazziesaccount@gmail.com>
 <685cd1affabe50af45b767eeed9b9002d006b0fd.1740993491.git.mazziesaccount@gmail.com>
 <Z8WXqgxgFQC8b8vC@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z8WXqgxgFQC8b8vC@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/03/2025 13:51, Andy Shevchenko wrote:
> On Mon, Mar 03, 2025 at 01:34:49PM +0200, Matti Vaittinen wrote:

> 
> What about the second loop (in gfar_of_init)?
> I mean perhaps we want to have fwnode_for_each_named_child_node()
> and its device variant that may be also reused in the IIO code and here.
> 

I agree the fwnode_for_each_named_child_node() would be useful. I think 
I said that already during the previous review rounds. There is plenty 
of code which could be converted to use it.

This, however, is far more than I am willing to do in the context of a 
simple IIO driver addition. The "BD79124 ADC suupport" is already now 10 
patches, 2 of which are directly related to it.

I propose adding the for_each_named_child_node() as a separate series 
with bunch of users appended. That's be plenty of beans to count for 
those who like following the statistics :)

Yours,
	-- Matti

