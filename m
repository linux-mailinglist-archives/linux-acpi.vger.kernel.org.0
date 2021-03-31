Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877E934FF6F
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Mar 2021 13:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbhCaL0T (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 Mar 2021 07:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbhCaLZz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Mar 2021 07:25:55 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0912AC061574;
        Wed, 31 Mar 2021 04:25:54 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j9so17578389wrx.12;
        Wed, 31 Mar 2021 04:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XKemW9z1W9iahD8xhRWW3yf2hOBr43rJJBDBt1M2nFY=;
        b=btDjiIRJcCIQsZ6Y8eRXXhmfdB2VsAVSAL3gf3HjIm9g8zreCGJgkJIcWmLA62blJv
         urljdWP9VbXrhE0LUCPg+BEkayFtukdFbbKbWNCmqYLvMUhnn3Mx1NWOOj/EEc671NX0
         IqUkVeOWGLUUyy/9yNz0VahjJogW92QwfnivDnSXFAT+9Nn6Q4iJ4uNIOA64NqHYV0vU
         760t6zefFpmFyUtnNPaagI+qMm9pdgek0+FQ/r+qgp9ljml9913Q5N60rfI2RVZck90/
         LQEaJFHPl9I9oFdDCcMwVbPfHxwYKQEMGkOWLrHkmzGcgHeLjqyjYm2SJskn+bXhArtA
         PrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XKemW9z1W9iahD8xhRWW3yf2hOBr43rJJBDBt1M2nFY=;
        b=lyQ2Ohw/WPHRueZP961JqDQEtEgDJ0l00w6libwKVBF+DNCTqHsMbJ31+Ve1iLjGA2
         u8+aa7G1PuOFC5QqXUI2JJzKLMMpGnq8L01q+S1ibAMRoUSRmMPghIqK3BGd2YXibqm0
         LpGdAqxPQV9SB2HwqlgaKxeMhy3z0BMU+fBRVLHNR8l3pvOujp1LJ/jrjpLEaMFsLfyB
         oSh2jrQ36KKXimH8JPtjN+gKPSj5qrnJSC8oKT1nwHvKsE+Lp71ZuwK9mpqpS79D6nUZ
         jTIa0CkwuzzBzLF3K+nADzN1+FV1easwCTAYczH2NB7RH6NAbkAcPfUzV8H7WrvVy12Z
         /3Rg==
X-Gm-Message-State: AOAM532VH0mwACoUR/C1afPtVq96KQOTOy+W2x0DaqbGFq0y5F+qKns0
        MjV3G0kZHexi96+qsXTSW3o=
X-Google-Smtp-Source: ABdhPJw/1/SEYE3fOUEOqFB/zEgCN6nAvixmM5sifER6k6+BoM2mwyGqEqg04/NiQ9HLu6BRDiEjBQ==
X-Received: by 2002:a05:6000:3:: with SMTP id h3mr3107372wrx.91.1617189952852;
        Wed, 31 Mar 2021 04:25:52 -0700 (PDT)
Received: from [192.168.1.211] ([91.110.20.103])
        by smtp.gmail.com with ESMTPSA id r11sm4025675wrm.26.2021.03.31.04.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 04:25:52 -0700 (PDT)
Subject: Re: [PATCH v2 5/6] software node: Introduce SOFTWARE_NODE_REFERENCE()
 helper macro
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20210329151207.36619-1-andriy.shevchenko@linux.intel.com>
 <20210329151207.36619-5-andriy.shevchenko@linux.intel.com>
 <5e76c3b8-d154-e5ca-25d8-290376469e5a@gmail.com>
 <YGLuyKFbDgVLU2OW@smile.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <26a22d2a-fb71-1651-5ff0-8332d95e9196@gmail.com>
Date:   Wed, 31 Mar 2021 12:25:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YGLuyKFbDgVLU2OW@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy

On 30/03/2021 10:26, Andy Shevchenko wrote:
>>> +	{ .pointer = &SOFTWARE_NODE_REFERENCE(_ref_, ##__VA_ARGS__), },	\
>> What are the .args intended to be used for? I actually had it in mind to
>> replace this with a simple pointer to a struct software_node, because I
>> can't see any users of them and the fact that it's actually storing a
>> pointer to a new variable is something that confused me for a good long
>> time when I wrote the cio2-bridge (though that's mostly due to my
>> relative inexperience of course, but still)
> It's to be in align with DT phandle references that can take arguments. While
> for now, indeed, we have no users of this, it might be changed in the future
> (I hadn't checked DesignWare DMA where I would like to transform the code to
>  use device properties eventually and there it might be the case).


Ah yeah I see - haven't come across phandles before but having looked
them up now I see what this is meant to emulate. Consistency is good; in
that case, for this and 6/6:


Reviewed-by: Daniel Scally <djrscally@gmail.com>

and

Tested-by: Daniel Scally <djrscally@gmail.com>



>
