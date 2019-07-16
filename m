Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5D186A13B
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2019 06:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfGPENZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jul 2019 00:13:25 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36174 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfGPENZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jul 2019 00:13:25 -0400
Received: by mail-yb1-f196.google.com with SMTP id d9so598079ybf.3;
        Mon, 15 Jul 2019 21:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KKcOLK0Pj5j6Y3pm/sSq/nV841duXzBCMR6JUm0phP8=;
        b=nqNSEK8ahmJLtrfN4mGe5uWwmPFJ/7ZmN+QmEH0a3h8JjHcmmZWKibZY4Jw32Qpb6x
         //3o9bUpJ4OgzhnQ/QEsQg9PYeauVUaca4fOFUgAg7Y8pcfbMhS9ZgCexNM13GIFjqqm
         1xhuirH/9zB1Qv/jUQIkh/ZeRPwFJDL57xCd3dPAaUDFimXMQNoI2ZNEY7A7GYfVSz3K
         dyLQV/Mx5wn6tJoOc+IV2EAh5OPz6eLitUj7BAgENeVEvrPcnqQaXiHxQbEIBiUjMocg
         h7OwOtc9is6+YvuuyRuPpqppOyR3onysH21/2dX3kdAv4OqxZ6NY4PkRyWX+xyj0paR0
         LHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KKcOLK0Pj5j6Y3pm/sSq/nV841duXzBCMR6JUm0phP8=;
        b=dO+MmKIdisq2FKyZlBEi/9nmBLpNpIpVQp5M/33mcMFKPtjwDoJH6xz3OxhEvv9dbT
         HOHmn1ZUXrnZIVMLgW6tfC5cmQyhQQ2pnshIa1eZrrX+Hx1s7bF227SwjS6+4FnD1+2i
         6dbbfPa7OqQ96QZO2SbpKTj34xn9yVMcRbjbmSouy4kd6Gd44SlXrnxXKwfbdtMbsU+I
         CiQ9MtQb6P3g6rqfEFoyuCTOjEds99T3sW3n5VSac8Icoelfk7MgB9OS+1j1Zpl0fS+D
         nY1+0a0EAw2zpzA5Hne0vPUNXEflg1BUEnQSYKVtSAEoBT9MGImCVh1G/koCeDCmMq7O
         iJrA==
X-Gm-Message-State: APjAAAXkqaYjm/MRvRfmXEE2u7Scvdco4RS2ckwJpktL/YoJ9nZT8qRN
        LWrc9ST0ckwhWk0toS23YAY=
X-Google-Smtp-Source: APXvYqzJytyvg97HkaCMtPls51uWFFWrbX9McCxj9NBTRCDd8b2zc0gANzQ+U/Ynx+UIGn5DMaL89w==
X-Received: by 2002:a25:ba11:: with SMTP id t17mr18194987ybg.24.1563250404840;
        Mon, 15 Jul 2019 21:13:24 -0700 (PDT)
Received: from [192.168.1.74] (75-58-59-55.lightspeed.rlghnc.sbcglobal.net. [75.58.59.55])
        by smtp.gmail.com with ESMTPSA id x195sm4882583ywx.57.2019.07.15.21.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 21:13:24 -0700 (PDT)
From:   Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH] ARM64/irqchip: Make ACPI_IORT depend on PCI again
To:     Sasha Levin <sashal@kernel.org>, marc.zyngier@arm.com,
        will.deacon@arm.com, julien.thierry@arm.com,
        catalin.marinas@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-kernel@microsoft.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        stable@kernel.org
References: <20190716040441.12101-1-sashal@kernel.org>
Openpgp: preference=signencrypt
Autocrypt: addr=okaya@kernel.org; keydata=
 mQENBFrnOrUBCADGOL0kF21B6ogpOkuYvz6bUjO7NU99PKhXx1MfK/AzK+SFgxJF7dMluoF6
 uT47bU7zb7HqACH6itTgSSiJeSoq86jYoq5s4JOyaj0/18Hf3/YBah7AOuwk6LtV3EftQIhw
 9vXqCnBwP/nID6PQ685zl3vH68yzF6FVNwbDagxUz/gMiQh7scHvVCjiqkJ+qu/36JgtTYYw
 8lGWRcto6gr0eTF8Wd8f81wspmUHGsFdN/xPsZPKMw6/on9oOj3AidcR3P9EdLY4qQyjvcNC
 V9cL9b5I/Ud9ghPwW4QkM7uhYqQDyh3SwgEFudc+/RsDuxjVlg9CFnGhS0nPXR89SaQZABEB
 AAG0HVNpbmFuIEtheWEgPG9rYXlhQGtlcm5lbC5vcmc+iQFOBBMBCAA4FiEEYdOlMSE+a7/c
 ckrQvGF4I+4LAFcFAlztcAoCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQvGF4I+4L
 AFfidAf/VKHInxep0Z96iYkIq42432HTZUrxNzG9IWk4HN7c3vTJKv2W+b9pgvBF1SmkyQSy
 8SJ3Zd98CO6FOHA1FigFyZahVsme+T0GsS3/OF1kjrtMktoREr8t0rK0yKpCTYVdlkHadxmR
 Qs5xLzW1RqKlrNigKHI2yhgpMwrpzS+67F1biT41227sqFzW9urEl/jqGJXaB6GV+SRKSHN+
 ubWXgE1NkmfAMeyJPKojNT7ReL6eh3BNB/Xh1vQJew+AE50EP7o36UXghoUktnx6cTkge0ZS
 qgxuhN33cCOU36pWQhPqVSlLTZQJVxuCmlaHbYWvye7bBOhmiuNKhOzb3FcgT7kBDQRa5zq1
 AQgAyRq/7JZKOyB8wRx6fHE0nb31P75kCnL3oE+smKW/sOcIQDV3C7mZKLf472MWB1xdr4Tm
 eXeL/wT0QHapLn5M5wWghC80YvjjdolHnlq9QlYVtvl1ocAC28y43tKJfklhHiwMNDJfdZbw
 9lQ2h+7nccFWASNUu9cqZOABLvJcgLnfdDpnSzOye09VVlKr3NHgRyRZa7me/oFJCxrJlKAl
 2hllRLt0yV08o7i14+qmvxI2EKLX9zJfJ2rGWLTVe3EJBnCsQPDzAUVYSnTtqELu2AGzvDiM
 gatRaosnzhvvEK+kCuXuCuZlRWP7pWSHqFFuYq596RRG5hNGLbmVFZrCxQARAQABiQEfBBgB
 CAAJBQJa5zq1AhsMAAoJELxheCPuCwBX2UYH/2kkMC4mImvoClrmcMsNGijcZHdDlz8NFfCI
 gSb3NHkarnA7uAg8KJuaHUwBMk3kBhv2BGPLcmAknzBIehbZ284W7u3DT9o1Y5g+LDyx8RIi
 e7pnMcC+bE2IJExCVf2p3PB1tDBBdLEYJoyFz/XpdDjZ8aVls/pIyrq+mqo5LuuhWfZzPPec
 9EiM2eXpJw+Rz+vKjSt1YIhg46YbdZrDM2FGrt9ve3YaM5H0lzJgq/JQPKFdbd5MB0X37Qc+
 2m/A9u9SFnOovA42DgXUyC2cSbIJdPWOK9PnzfXqF3sX9Aol2eLUmQuLpThJtq5EHu6FzJ7Y
 L+s0nPaNMKwv/Xhhm6Y=
Message-ID: <a688793b-f7e8-18a4-3eb2-877f1522d8f3@kernel.org>
Date:   Tue, 16 Jul 2019 00:13:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190716040441.12101-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 7/16/2019 12:04 AM, Sasha Levin wrote:
> ACPI_IORT lost it's explicit dependency on PCI in c6bb8f89fa6df
> ("ARM64/irqchip: Update ACPI_IORT symbol selection logic") where the
> author has relied on the general dependency of ACPI on PCI.
> 
> However, that dependency was finally removed in 5d32a66541c4 ("PCI/ACPI:
> Allow ACPI to be built without CONFIG_PCI set") and now ACPI_IORT breaks
> when we try and build it without PCI support.
> 
> This patch brings back the explicit dependency of ACPI_IORT on PCI.
> 
> Fixes: 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> Cc: stable@kernel.org
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Do you have more detail on what really is broken without this patch?

It should be possible to build IORT table without PCI.

