Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569732E973C
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 15:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbhADO0F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 09:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbhADO0E (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2021 09:26:04 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9A0C061794;
        Mon,  4 Jan 2021 06:25:24 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q18so32399732wrn.1;
        Mon, 04 Jan 2021 06:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cgMa1ozf7rkti5mLh6+NpCyuU7N0LHsi65KW2RkpvS8=;
        b=oc2nISQUFGSEbWG33TCyqORJyvGqtyH5k04ui5YC15IRe2hzK2ti/P15pBCMfTTAeo
         /Vlx3zjWEz0fTaVDMqYl+6/MgtcEzq/GXNQKjEzzTh6Q4+G6n5JnplcwJHlVAA1smMLf
         IOvLJMkqLQgyd7s9aRJldx9lfjWml5/Wl0xJ93JvVUjPbmaImnzLEQt+6AGpLeMmPpmc
         O+fYQbHcY3rwBMKKhZmIKXE6tZ4XLtK/cxQX8TwHSsTinip0OZJ31fWnE737nrBweQJR
         snWIgYiKFOQquusB6M74Vh/h/czZHvhFY/o7I2iNxeIi2LJzwF43iW/LWC+KXHDVRuDZ
         HUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cgMa1ozf7rkti5mLh6+NpCyuU7N0LHsi65KW2RkpvS8=;
        b=goa0/Et4JKWocsprlQ5cZufLN0uHIWmb2KPLMobnQ4fXXFWP/p7tDPLC3hPaKsj0I1
         IeRebR9ug3Xbj1QI0Cdu7u1lNBB/nkicdaBQb9BXgIdTD6KgLyd6Q8CbUNvmNFMnFZHv
         zW5WQnrEqxwDlBW/gd+BX1cq3m9Bu752SS+EVBX3N5wx/YW86MlzImZQ6H+7s31UBdT1
         nZ4KcwpTcVxjDnrsILfEXOPkIZKrIgQo/NFTKY3P7GiFlGlkVaxWb3kOsQoa+v+izRrX
         GPmiXdj18fUzfyOze71VxP54E+tUDs/NCukKK776/uaNgzYXzrf1jbwnhyjPD9nvOHsg
         hxdA==
X-Gm-Message-State: AOAM53043N3JDpjediq5/Za8bt57fr+3YOCxKmCvBkPd36tUz7xIBg2p
        ntP9VRNDa1LHD8YhqdRryhA=
X-Google-Smtp-Source: ABdhPJxjtsFZBVDqg61/r2s5iovNcyXthUWfcJec5G0wW3OrYvXPwvFIjZKyHbjTHTYMJ15uosItLw==
X-Received: by 2002:a5d:5917:: with SMTP id v23mr79689802wrd.308.1609770323001;
        Mon, 04 Jan 2021 06:25:23 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id j13sm32945558wmi.36.2021.01.04.06.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 06:25:22 -0800 (PST)
Subject: Re: [PATCH v4 07/15] include: fwnode.h: Define format macros for
 ports and endpoints
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
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20210103231235.792999-1-djrscally@gmail.com>
 <20210103231235.792999-8-djrscally@gmail.com>
 <20210104142425.GW4077@smile.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <4b427ef6-784b-abb5-4fe5-abdeb9645db7@gmail.com>
Date:   Mon, 4 Jan 2021 14:25:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210104142425.GW4077@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 04/01/2021 14:24, Andy Shevchenko wrote:
> On Sun, Jan 03, 2021 at 11:12:27PM +0000, Daniel Scally wrote:
>> OF, ACPI and software_nodes all implement graphs including nodes for ports
>> and endpoints. These are all intended to be named with a common schema,
>> as "port@n" and "endpoint@n" where n is an unsigned int representing the
>> index of the node. To ensure commonality across the subsystems, provide a
>> set of macros to define the format.
> Since v5, can you modify subject prefix to be "device property: "?
> Same for patches 3 and 4, please.
>
Will do, and for your last email too.
