Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F43F2C7738
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Nov 2020 02:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgK2Bjg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 28 Nov 2020 20:39:36 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.116]:35436 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726472AbgK2Bjg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 28 Nov 2020 20:39:36 -0500
Received: from [100.112.133.223] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.us-west-2.aws.symcld.net id F0/D2-25369-CBAF2CF5; Sun, 29 Nov 2020 01:34:52 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRWlGSWpSXmKPExsWSLveKTXfPr0P
  xBsvuC1jsvy5h0bXQwGLh/VOsFl+/3Wa3eHN8OpPF8n39jBafOyazWKze84LZYu2XeWwWZ05f
  YnXg8tg56y67x69ta1g8Nq/Q8ph3MtCjp20Tk8f7fVfZPLZcbWfx+LxJLoAjijUzLym/IoE14
  9/OjSwFyzgrHq7czdTAeJi9i5GLQ0jgP6PEhzlHmCGcF4wShzd1snQxcnIIC6RK/N41FyjBwS
  EiYC/x4kkQSA2zwHFmif0XvrFCNLQySdzYOoEZpIFNQFtiy5ZfbCA2r4CtxPvWaWCDWARUJVZ
  3PAezRQXCJdYvWckIUSMocXLmE7A4p0AXo8TxpgAQm1nAQmLm/POMELa4xK0n85kgbHmJ5q2z
  wXZJCChIrLxzmA3CTpBY9vIO8wRGwVlIxs5CMmoWklGzkIxawMiyitE8qSgzPaMkNzEzR9fQw
  EDX0NBI19DYWNfMQi+xSjdJr7RYtzy1uETXSC+xvFivuDI3OSdFLy+1ZBMjMA5TClpddjD+f/
  1B7xCjJAeTkiiv1/VD8UJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkeBf8AMoJFqWmp1akZeYAUwJ
  MWoKDR0mEV+UnUJq3uCAxtzgzHSJ1ilFRSpxXFiQhAJLIKM2Da4OloUuMslLCvIwMDAxCPAWp
  RbmZJajyrxjFORiVhHmvgGznycwrgZv+CmgxE9Bil//7QRaXJCKkpBqY7gdMuMX8X52fhU3ui
  J9vovz35r7/WruFiu3628zdFx9pU9+i51qZbZJ66s+Ki0zO8bl792uGmN2I5Ln5w8/Ssf5Cft
  WXv/5mxnf+r5/iskD5gWyAVvGz7xLbql4HpIeWiyvJbRQ657C8aq9GW0LfRqc7M/fdltXa/eT
  xr9Zlct9LFtZdv/Eigmnv4r+n5WuWKT2abcjYWy7u+utewEwDE9tnL7esqNTewbVwr0z84skZ
  hTb714TxbeC5zdvqa7eGwWzBC6/YpVXli/dIz3TKMN98ozLJOc2dO+ywgb72nhPnUruW3LMtX
  LL257fK1OcTeSQ9s16o/O+43Ptmmu7VlX/ltn/w3HZMwPLr8+chSizFGYmGWsxFxYkAacqbzr
  4DAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-10.tower-356.messagelabs.com!1606613690!57407!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28018 invoked from network); 29 Nov 2020 01:34:52 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-10.tower-356.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 29 Nov 2020 01:34:52 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id A35C8EB7E4FC0B96B1E7;
        Sun, 29 Nov 2020 09:34:47 +0800 (CST)
Received: from localhost.localdomain (10.64.84.236) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Sat, 28 Nov
 2020 17:34:43 -0800
Subject: Re: [External] Re: [PATCH v4 3/3] platform/x86: thinkpad_acpi: Add
 platform profile support
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
CC:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "eliadevito@gmail.com" <eliadevito@gmail.com>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
References: <markpearson@lenovo.com>
 <20201126165143.32776-1-markpearson@lenovo.com>
 <20201126165143.32776-3-markpearson@lenovo.com>
 <ioprVbNER4h0HTVvyj2ElXiuNaSPjl8ycgp4XtOtj-Iwe4_6qnNRLYuvxIJKE2ULGPTRURY-1Dr9plCocTnx2S_ugBn7INWZScnn4-pTq4c=@protonmail.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <26f5118a-2bbd-d5c6-a1ff-c9fb80e5f5f7@lenovo.com>
Date:   Sat, 28 Nov 2020 20:34:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <ioprVbNER4h0HTVvyj2ElXiuNaSPjl8ycgp4XtOtj-Iwe4_6qnNRLYuvxIJKE2ULGPTRURY-1Dr9plCocTnx2S_ugBn7INWZScnn4-pTq4c=@protonmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.64.84.236]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Barnabas,

On 2020-11-27 2:22 p.m., Barnabás Pőcze wrote:
> Hi
> 
> 
> 2020. november 26., csütörtök 17:51 keltezéssel, Mark Pearson írta:
> 
>> [...]
>> +static bool dytc_ignore_next_event;
> 
> As a sidenote: can the profile switching be triggered by means that's not the
> `/sys/firmware/acpi/platform_profile` attribute (e.g. a physical button)?
> Because if so, then I'm not sure if `dytc_ignore_next_event` achieves its purpose
> robustly, although I believe it won't cause issues in practice. I think it could
> be made more robust using a mutex to serialize and synchronize access to the DYTC
> interface, but I'm not sure if the effort is worth it.
> 

A user can do FN+L, FN+M, FN+H to switch mode (though hopefully with 
this API and the support in user space they won't need to do that any more).

So I think you're right about this area having issues, and Hans picks up 
on this too. I had avoided a mutex as I thought that would cause 
problems in the event handler. In Han's email he suggests an atomic int 
and I think that could work nicely but will have to try it out and see.

Regardless - I agree this area needs some work and I'll look into it

Thanks!
Mark

