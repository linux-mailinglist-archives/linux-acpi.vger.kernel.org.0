Return-Path: <linux-acpi+bounces-6600-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 572D4915931
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jun 2024 23:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9021C212A3
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jun 2024 21:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75D51311B5;
	Mon, 24 Jun 2024 21:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lscD1rUp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC7B4962C;
	Mon, 24 Jun 2024 21:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719265548; cv=none; b=kJ4YFCL5B9n3AwQWbUQeDTseaxodVG2RlgWuo661ePsTlr1Aux9BO+/508yZm/HDVJwkIX2mnFZa59yWqh38GEliJEpOlBWbz8ykAy9EGZawz16FsmC11wsMyEGVx7ejAmWduy67Wu8/UMb2sIynWZkX56hq5avbwFi+JAxADgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719265548; c=relaxed/simple;
	bh=5LDOUY5x0WIdNRBUPnBNwAdwzAxdcTUC+9ltGMgcDz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWchOw3CwyfQbZCfC0GUqnl8Nszlw+Q17Dhz/4ZSu1hkoJwuv6qNGz+qxZklZJL+F8zcsf30g4e8kEFd0vFH28veE/oM+14+HnhrfkiHLOwMeybq/4ASb9cn5xRUSlayxN2jiX1OJ1KFqIszdyN9gpw3WjZxvD58UrPrvZXJ/hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lscD1rUp; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-363bd55bcc2so4046361f8f.2;
        Mon, 24 Jun 2024 14:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719265545; x=1719870345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BPPDvN7v6IiPVFVviCh6dtINUu1WsSok2eDdprbo4Ic=;
        b=lscD1rUpUDEzrjwp3Iycpv2avGpTiwpo5fxcaZF3G4dKBs7EMLw9CmijAkwTdvH9Qd
         7bbMdF7LqWAyN6OtgN3Jyhol/FldtwZpu6bOCdRwW4LmQobMchXqx5J7C731AV7BXgvc
         YOvuhfvRBdKINkX5o3jiAb8r9AuQbeMorT+Di9rwPo82hs/tswNNeseeinstL0rKtuP5
         iaVmCcb5dpWIp1zYIANeFI+AX7y3yr32hCnGxhxfBSTBnyOv3CXBeqY3ekl/ngxe6IpH
         /1yIZRV7jhMxM6cZkJuTURjdIVMzC86ujzebDTK4Kz6YugDEBJFD+GJfC3luEC0NrfxV
         JRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719265545; x=1719870345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPPDvN7v6IiPVFVviCh6dtINUu1WsSok2eDdprbo4Ic=;
        b=xIfeAmrkGOUvQPIxJqAZ3L3snzYgt81xg01vx/oUSMTsqMPTwwLiTDhpz1RBftM5+3
         hTW2fl8Ia6+1ojs3PwPgIyNQ6QnP+7245qoWimzGSIvaqIuo1d4bHSdTH6x5/pR+PYfs
         y400V92tMoAUZb35P2womyItFQVyoS2VZMJ5UZ2HlZQkbgernFLzVMRCV8ofB4kRpghc
         SxyMzwS+vpPCW56/7E8M7CA5AD5q0cJho0E1ImNVMzKU6eYaFPk17GsfSXXvtAhr+Y6d
         1ryU7D7lRdy3ErMnwVY0TsmuddXwDZ1d64XOnxQUsugFiV9D3xOJjlbOIH0DuwneS3/2
         UH9w==
X-Forwarded-Encrypted: i=1; AJvYcCXnZCnWp66mYLUNbvf+Ppl5qiJok7SMvGMYl5jJAG8bW91Ups1KLcQpSLSWVgM242C+wSNPDAa8i/5NLMLLbV+fzNlDU1h9qi652arAvC8zoF1XQq9TIHJRIiBPx0eAL1doEsmSpbCNYc8ZwJZW9wet3EiOkubh5RfFy8LQ+qG95BTGed16G357J3GgFH2W32X2DW9UVBF9dHhZzECxnPOFJA==
X-Gm-Message-State: AOJu0YzOcslpTbKFaA9Me1l6Y3P2pAdn/HDanMTV1EKlKIsY/kLaP+iS
	+0g7ak/1Wfib23GEUKsyDctTVyOlaJGQ0tvy/wyl9p/rObL04z8+
X-Google-Smtp-Source: AGHT+IHomXUaIVhT/771lPLn9rwX6XcDNC8dy89avGpfMRSOgnyNEQVProIVICbppqDUT8SI6DtKJg==
X-Received: by 2002:a5d:400a:0:b0:363:107d:8385 with SMTP id ffacd0b85a97d-366e94cbca0mr4071088f8f.34.1719265545301;
        Mon, 24 Jun 2024 14:45:45 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-103.cable.dynamic.surfer.at. [84.115.213.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f65easm11118821f8f.23.2024.06.24.14.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 14:45:43 -0700 (PDT)
Message-ID: <3a16dc06-81df-4493-bac6-216e9c6ea16e@gmail.com>
Date: Mon, 24 Jun 2024 23:45:42 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] hwmon: (ltc2992) Use
 fwnode_for_each_available_child_node_scoped()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
References: <20240523-fwnode_for_each_available_child_node_scoped-v2-0-701f3a03f2fb@gmail.com>
 <20240523-fwnode_for_each_available_child_node_scoped-v2-3-701f3a03f2fb@gmail.com>
 <20240526144851.493dd3f2@jic23-huawei>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240526144851.493dd3f2@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/05/2024 15:48, Jonathan Cameron wrote:
> On Thu, 23 May 2024 17:47:16 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> The scoped version of the fwnode_for_each_available_child_node() macro
>> automates object recfount decrement, avoiding possible memory leaks
>> in new error paths inside the loop like it happened when
>> commit '10b029020487 ("hwmon: (ltc2992) Avoid division by zero")'
>> was added.
>>
>> The new macro removes the need to manually call fwnode_handle_put() in
>> the existing error paths and in any future addition. It also removes the
>> need for the current child node declaration as well, as it is internally
>> declared.
>>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> This looks like another instances of the lack of clarify about 
> what device_for_each_child_node[_scoped]() guarantees about node availability.
> On DT it guarantees the node is available as ultimately calls
> of_get_next_available_child()
> 
> On ACPI it doesn't (I think).
> For swnode, there isn't an obvious concept of available.
> 
> It would be much better if we reached some agreement on this and
> hence could avoid using the fwnode variants just to get the _available_ form
> as done here.  Or just add the device_for_each_available_child_node[_scoped]()
> and call that in almost all cases.
> 
> In generic code, do we ever want to walk unavailable child nodes?
> 
> Jonathan
> 

Hi,

if I did not miss anything, the discussion about the convenience of the
fwnode_for_each_available_child_node_scoped() macro stalled without a
clear outcome.

At this point there are multiple users of both
fwnode_for_each_child_node() and fwnode_for_each_available_child_node(),
and I wonder how many of them use the non-scoped version for a different
reason than not having/knowing the _available_ variant back then.

Maybe touching that now could turn into regressions if someone is just
ignoring that some nodes are actually disabled. Their bad, but still
painful. But maybe there is a better reason to have both macros I don't
know.

As I am still interested in this matter for new users that only want to
iterate over available nodes, and I want to have a scoped solution, I
would like to revive this discussion.

Thanks and best regards,
Javier Carrasco

