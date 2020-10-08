Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDC1287B18
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Oct 2020 19:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgJHRjR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Oct 2020 13:39:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725908AbgJHRjR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Oct 2020 13:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602178755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=57pF96nMveuIgLAIF741tVuUvsmgggpGyKeIRqwrjbM=;
        b=eEf8XzeNCXRdCCtmK1mbhDvP9elPVOiElRWHfZ8Z59TTil5DyqpdzQrXBsbXwMWO7b2Fub
        PWQ48OurCj3JCnwpkI5noTp7JFvd07/e5CAwVN0OKLa71FKkAwgRnuDX78YLopfH6jN6DZ
        jaQBgze+Fmi0NYXPB3rO5S5Eq53xnt8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-RrAE_2J9OGGn-j7LOgyeMQ-1; Thu, 08 Oct 2020 13:39:13 -0400
X-MC-Unique: RrAE_2J9OGGn-j7LOgyeMQ-1
Received: by mail-ej1-f72.google.com with SMTP id x12so2477344eju.22
        for <linux-acpi@vger.kernel.org>; Thu, 08 Oct 2020 10:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=57pF96nMveuIgLAIF741tVuUvsmgggpGyKeIRqwrjbM=;
        b=j+FLfK/F9ZGdhQDhI/RSI8lua4Ji/wtl/fqVJNQ1kzYJW0NzpmLcLcvlDra/RfbME0
         tI7UzlxUlqXi5B3DfzSW8Vubhn7P5R8ntUQsfRCYzqGZOO7Tzuhp1CtghbzyU+c7QmTE
         MhY2eUmh36xA+2uHWvZiHNEf5rHngR25ZmReunP7d2UHWollc2WzR4jPef6Y/s28x32t
         kDCT/4mbyUXbBMjaqoO3ap18JY6gg/njlLbcqx4IsISPXJKeHckXYhLKNixW/uGdpOJh
         xJHendN44K7vw6ITAYILwrmGFFeHcMbat+4WKjdWDv1qgf0ZULJawXujZE9zd/L4/f73
         eI/A==
X-Gm-Message-State: AOAM5303vfPkaZdte9TpncxJxutaHvhJfEI9Th/bdCCupkyZTQTokubI
        +z2jzgEzZ0B8yvOgHuh3W3g+hPbhksdxOV2PUk2+eo90rTK1MJOkh05gpwVGI8QgTEy6XTQvt8e
        R4xDRTUrxRdJudo+DRd92cQ==
X-Received: by 2002:a50:ef0a:: with SMTP id m10mr10343236eds.116.1602178752509;
        Thu, 08 Oct 2020 10:39:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEtunoREN2MGffbkQijQPSdkbi+W/TWv89PFtLjh/Rito+m4UtcOPtGzgjd8aLEVRc71hxQg==
X-Received: by 2002:a50:ef0a:: with SMTP id m10mr10343216eds.116.1602178752280;
        Thu, 08 Oct 2020 10:39:12 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id k1sm4549656edl.0.2020.10.08.10.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 10:39:11 -0700 (PDT)
Subject: Re: [PATCH v2] pinctrl: cherryview: Ensure _REG(ACPI_ADR_SPACE_GPIO,
 1) gets called
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        stable@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
References: <20200504145957.480418-1-hdegoede@redhat.com>
 <20200506064057.GU487496@lahna.fi.intel.com>
 <f7ebb693-94ec-fd9f-c0a8-cfe8f9d4e9bf@redhat.com>
 <20200507123025.GR487496@lahna.fi.intel.com>
 <3d7ce79f-6157-8ae0-dae9-ebc940120487@redhat.com>
 <20201008144450.GU2495@lahna.fi.intel.com>
 <1925077c-dc47-bc93-6f7b-b8fdbd6efcd8@redhat.com>
 <20201008155222.GW2495@lahna.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <efcd512b-9072-5807-b7e6-79a2aa413273@redhat.com>
Date:   Thu, 8 Oct 2020 19:39:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008155222.GW2495@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/8/20 5:52 PM, Mika Westerberg wrote:
> On Thu, Oct 08, 2020 at 05:37:10PM +0200, Hans de Goede wrote:
>> Mika, do you have input wrt always calling _REG for just the
>> GpioIoOpRegion type (on top of the existing EC exception) vs
>> just simply always calling it for all all/more OpRegion types ?
> 
> IMO it is safer to call it only for GPIO (GpioIoOpRegion) now.

That was my thought too, and is what my current patch does.
Thank you for your input on this.

Regards,

Hans

