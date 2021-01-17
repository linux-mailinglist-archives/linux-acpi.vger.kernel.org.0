Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC212F956A
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Jan 2021 22:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbhAQVPz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 17 Jan 2021 16:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbhAQVPz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Jan 2021 16:15:55 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26E7C061573;
        Sun, 17 Jan 2021 13:15:14 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id 6so7321165wri.3;
        Sun, 17 Jan 2021 13:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jU5xZt4ZGGg5V25qXIr6WdPMU0NBUDnBFNWZBAT6X+0=;
        b=Tz9UVGWXaGHqzyAQCbw3J/kzNbeG0QwiRtDaiv3Tfx+tT+9OZ8P/xv0D6SBiPGSkAD
         7JufDrDEyqlzV5eXk4pIJB7LuX40V6tVTlYC4H6SYOq+h6Aioucms3ODro/SSW7twhYg
         51uuk2qi0ttMbQOOIvCi+lvAgOJJfqroDqXSpmTTrOfA623PZ6h/e0K1q6H9BwShTe41
         snbenmG+SYePulp56f8DVe8QJ7dn788mMPlZkg4mD6Ey8uunixsHQZ+YlYhVn57Scuq4
         DCU//k8R1zAAGhK1ONpTIJm9uaTruZRRFZ92qoGrfKrNON2tcXRxyVDdZkn+0A62QrhJ
         T9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jU5xZt4ZGGg5V25qXIr6WdPMU0NBUDnBFNWZBAT6X+0=;
        b=RvvfU2ZyyDGKeFEC/kxu6FIsClBuSVGHG9imY9YnCCSXPk6hNhLab8smPnWlrJ4n3a
         pBQlNKlqI1bryv8L8A54m0U30hIPhxZbt3ArEMcX0LqlPNPZzXqhh3qocYRnlSDlsaB5
         VfTuiyb0GAP9YLyItyFzXIf36XT7KUsV2evVVV8jpuIRhniqFuOnkrpWZzf+lInY0UMv
         Qg5h4JKPL6bGRFe3cZoMLyLy9JZytUw2i8xGM6u5XVsIhOdgFTgS8j7ulpjiwaqf0j6X
         qeFI7ZwpmqfpsKIg9knIdEFG9Z2EtNr6GGmtCb7oV8rZbPDDgg87kI6/infSrjK68OD0
         sxyw==
X-Gm-Message-State: AOAM531dV1abRyq6CLh5x8Tsi2ga0ttURk8F0MRzigbGZpkQU0I4q6J6
        O2ur6RcYCq+9M6VWxRJZTA/tHylfBIA=
X-Google-Smtp-Source: ABdhPJzeZMKzgf7s2G+Fjc7CxiN7nf8qJ818bKfHiQ3vOEyJ4dwhfkGs/dDeLV9G68Z1GHr9f4My8Q==
X-Received: by 2002:adf:f6c9:: with SMTP id y9mr23315026wrp.121.1610918113281;
        Sun, 17 Jan 2021 13:15:13 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id o18sm4270956wmh.20.2021.01.17.13.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jan 2021 13:15:12 -0800 (PST)
Subject: Re: [PATCH v3 0/4] Remove one more platform_device_add_properties()
 call
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <greg@kroah.com>, Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20210115094914.88401-1-heikki.krogerus@linux.intel.com>
 <CAHp75Vc3xjaOugX3d8bohz12OEP=n4BAonNyQJQ=UgBfVZorOg@mail.gmail.com>
 <c644e72c-bb46-56c2-931e-7cb98b024cc3@gmail.com>
 <CAHp75VfMOcPyXELoD4S+oQjAaVg6H0Hn2hs2UAbYEKhnFZp36A@mail.gmail.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <073ee5a2-65e1-f5b3-c1be-6a1b37475563@gmail.com>
Date:   Sun, 17 Jan 2021 21:15:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfMOcPyXELoD4S+oQjAaVg6H0Hn2hs2UAbYEKhnFZp36A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 17/01/2021 21:05, Andy Shevchenko wrote:
> On Sat, Jan 16, 2021 at 11:29 PM Daniel Scally <djrscally@gmail.com> wrote:
>> On 16/01/2021 20:23, Andy Shevchenko wrote:
>>> On Fri, Jan 15, 2021 at 11:52 AM Heikki Krogerus
>>> <heikki.krogerus@linux.intel.com> wrote:
>>>> Hi,
>>>>
>>>> I'm now clearing the dev_fwnode(dev)->secondary pointer in
>>>> device_remove_software_node() as requested by Daniel and Andy. Thanks
>>>> guys, it's much better now. I also took the liberty of including one
>>>> more PCI ID patch where I add PCI ID for the Alder Lake-P variant. I
>>>> hope that is OK.
>>>>
>>>> Andy, I dropped your Tested-by tag because of the change I made to the
>>>> first patch. If you have time to retest these, I would much appreciate.
>>> Since Greg already grabbed a v3 I will test it when it appears in linux-next.
>>>
>> It seems the grabbed one is the v2 one though actually
> In his last message he wrote that he noticed the v3 *as I understand that*.
> Greg, is it right? I mean you took v3 eventually?
>
You're right:

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-testing&id=e68d0119e3284334de5650a1ac42ef4e179f895e

My bad; I went off the automated message but didn't check the tree.


