Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CA12E9561
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 13:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbhADM6T (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 07:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbhADM6T (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2021 07:58:19 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DCCC061574;
        Mon,  4 Jan 2021 04:57:38 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d26so32018389wrb.12;
        Mon, 04 Jan 2021 04:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ggZkcYC9h5eVQbnMgWr/AEjs49D98jiYmnWX9w592LA=;
        b=RthGD3EnZ0QY82azYylIrogBzOuAAMaMnijfhP1X2DdqXrhTEPiIcU5VrcujCuQL2q
         DCZqVEgCC54uR3LGvnOpFgEiwvcn11L2tFFx2I0GPDi2TUH0RMMeAdxeHcu6zwt8JGnS
         0YcdUq/y/Gp9AaGaNkMI755ZU5ZrLg54gSfaa8rzEaurBFDeuABmcUtMxq/Cq5cZXwd6
         1LDeB9CrRVwxUsgOXI5/y2T89JyLiyz7yvAdDAoLz4eQ/uAnZJgCnKm8G/Zf34K5mXPH
         6De2HngJjL8JhC2ku8v8oSb5pUQCfAcRJiWOcweeWqk9ueua30ZTSHvuordU73FUkKTE
         tu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ggZkcYC9h5eVQbnMgWr/AEjs49D98jiYmnWX9w592LA=;
        b=Naqk4RitQDKG+S+EIsuL9m43TcKQv1j6JlsAbvHt9gC1PhltPs9f+OzCFGIe8AFI1V
         2SucSP2NOYxo3KWAjDIWLs0E1ylNm2/3s8FxuxcDVw5Gu/uGkmi3aLXSDZ1eIrQfl/tU
         xE26lRoGSggqDg3wuS9ay4Bl9LHcyGQz8fEOLVti+1rdfL7pEPMfTftVtasIjz+dWNgs
         5qIX6PFVv+PW7BHtYSxboJlh+nohqPgVJZLN2Quv+dr4kppEyZjKLOUPpVoFj0fNzfPG
         pO+yTH0SZ7ztsGITqR0Okkab6oZaCwyb9UtWg2Qfv9uPDl7BqP143pGoSupd3Vb8Y843
         f0Kw==
X-Gm-Message-State: AOAM5335z8iIus/83o8+i9tDqjj/bR09l3n+wl4fGG2Ma9spUwqknlb5
        JmH9TBAZa+5Xk1hkdvfrBhw=
X-Google-Smtp-Source: ABdhPJybuSzgoyfe7x0voEhgCYurOZwxvWtHX/XkD78yXa/Fkmh73V1dqnivY+FCfRVigb88QV50iA==
X-Received: by 2002:a05:6000:144f:: with SMTP id v15mr65709613wrx.138.1609765056599;
        Mon, 04 Jan 2021 04:57:36 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id i16sm87087466wrx.89.2021.01.04.04.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 04:57:36 -0800 (PST)
Subject: Re: [PATCH v4 13/15] acpi: Add acpi_dev_get_next_match_dev() and
 helper macro
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        sergey.senozhatsky@gmail.com, mchehab@kernel.org, lenb@kernel.org,
        yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org
References: <20210103231235.792999-1-djrscally@gmail.com>
 <20210103231235.792999-14-djrscally@gmail.com>
 <20210104124228.GU4077@smile.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <589d7078-60e6-ae2b-dbb2-bbe5b8ef7775@gmail.com>
Date:   Mon, 4 Jan 2021 12:57:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210104124228.GU4077@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 04/01/2021 12:42, Andy Shevchenko wrote:
> On Sun, Jan 03, 2021 at 11:12:33PM +0000, Daniel Scally wrote:
>> To ensure we handle situations in which multiple sensors of the same
>> model (and therefore _HID) are present in a system, we need to be able
>> to iterate over devices matching a known _HID but unknown _UID and _HRV
>>  - add acpi_dev_get_next_match_dev() to accommodate that possibility and
>> change acpi_dev_get_first_match_dev() to simply call the new function
>> with a NULL starting point. Add an iterator macro for convenience.
> I guess we need Rafael's blessing on this.
For this one yes
