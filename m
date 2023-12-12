Return-Path: <linux-acpi+bounces-2300-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A4480E395
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 06:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F373D1C218F4
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 05:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2300FFBFE;
	Tue, 12 Dec 2023 05:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu9Gqe9d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46036CE;
	Mon, 11 Dec 2023 21:16:41 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5c66e7eafabso4377763a12.0;
        Mon, 11 Dec 2023 21:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702358200; x=1702963000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vHBI7wjQdnZ+DZ//UHsAdWPwkfeLZbBEd4PpF6/sKrg=;
        b=Hu9Gqe9dwCIUGLCZYq2G8dZbzGTNzRUNFoe6GRXDMiZgLp38cX+e6qmxxgI6jJcyWo
         bKJM0iH2AN7mvY8UbDTz17H5RSJM1VHZ17sdoHUvCRIUlIjk5+M07qUprUQpXQ0TNog0
         du6/LKBFZns+/UY/7AZj4ltrXubo86ajKg+I5bS3RNWGfTt7H/kejYL1Q6Yu9CWtDF1K
         czVxT5YoU8Cu0nDouOHUcY4iBBYJUL9qR/F7gcQO8NdTCp2NUDIm5ZnRcJk5uvTUFiK/
         D3kXEqZyvK3plWkdi1JXPbY32Xb1T3rmuHqWE+Fb/FvAdLdbuuNgSuS7oxlZx16asmRf
         3tjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702358200; x=1702963000;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHBI7wjQdnZ+DZ//UHsAdWPwkfeLZbBEd4PpF6/sKrg=;
        b=eUBbrlSITK4pKicNCJ/C6h39IZRUyUeVMEe8OxkWcS93q4+0vvckjbac8lJ6HsKgNI
         6kw8CqAW1ZlmXB5sdrZfKGn8P4Y4+MY8QxEjfW1iIhehoZKYLA28K2A5swTesrvpVNdD
         G8SB/LJ7qhp+2bgzOrR7K3pbIw9qc6TekeRWVe76Rw2MKqmK/hmBfQlWCbGFfqewEy61
         pD3t/00xqs6cefa1fbeotSBf1vKnP6sIQplL/U4PMfZIdCMrVCOX9PDmZ+fkMOcNbEBG
         94ikk8FJJWByJSA8/i1ADjipRJJt62aDxMNAWJe5nHBXtgAAqwK/1kSSbezzdlglVKfV
         aZgw==
X-Gm-Message-State: AOJu0Yy1FpYDP+YWL+SGHxQPb+fx1D6GiiW1+ZlxSxbTMP4ryIEjp9Pc
	4v4B3mZQVUMfQ1I5ktp0Vd43KwsxABs=
X-Google-Smtp-Source: AGHT+IEyWhJ5rsuOwEvCUR7c9RqZvy7SYmTMhZgwdNZQtRZK3rHsgVLrcskDRw8XtBh1KVv98O6X+w==
X-Received: by 2002:a17:902:ea03:b0:1d0:6ffd:9df5 with SMTP id s3-20020a170902ea0300b001d06ffd9df5mr6696131plg.71.1702358200558;
        Mon, 11 Dec 2023 21:16:40 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 11-20020a170902c20b00b001ce664c05b0sm7624675pll.33.2023.12.11.21.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 21:16:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <73c85ee9-de13-4021-84a8-d45764ee2069@roeck-us.net>
Date: Mon, 11 Dec 2023 21:16:39 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Deterministic device paths for ACPI instantiated hwmon devices
Content-Language: en-US
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <9d52cc19-062b-4b8d-a9a0-bc2101dccab4@alliedtelesis.co.nz>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <9d52cc19-062b-4b8d-a9a0-bc2101dccab4@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/23 18:52, Chris Packham wrote:
> Hi,
> 
> We're looking at our first in-house modular product using an x86_64 CPU.
> Previously we've done other products using other various embedded CPU
> architectures which make use of a device tree for describing the hardware.
> 
> We've got some userspace code which tries to present end-user consumable
> names for various hardware monitors on removable modules (e.g.
> "temperature sensor 1 on the card in bay 3").
> 
> We do this based on knowing the deterministic path of the device in
> sysfs (e.g. /sys/devices/platform/soc/i2c0/lm75@2e) that works fine for
> devices instantiated on a device tree aware system (using device-tree
> overlays). However we've yet to find any way of getting a deterministic
> path out of devices instantiated via ACPI overlays. For now we've been
> using the `/sys/class/hwmon/hwmonN/device` paths but the N depends on
> the order the hardware was discovered which may not be the order the
> end-user expects.
> 
> Is there a way of inferring/influencing the numbering that gets used in
> the `/sys/devices/LNXSYSTM:00/LNXSYBUS:00/AMDI0010:00/` paths that
> appear when the devices get instantiated?
> 

Did you try sensors_get_detected_chips() from libsensors ?

Guenter


