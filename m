Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1167E3650C0
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Apr 2021 05:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhDTDUi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Apr 2021 23:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhDTDUh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Apr 2021 23:20:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E453C061763
        for <linux-acpi@vger.kernel.org>; Mon, 19 Apr 2021 20:20:07 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id bx20so42097726edb.12
        for <linux-acpi@vger.kernel.org>; Mon, 19 Apr 2021 20:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uGAruIhfl5PbFQl3w9o1oFcfZ2mxOXPUkTfgPA5jlzw=;
        b=lMK4t/iAncffACX3fI7gk9Lghwl2CzgkxeTG8FcsXurOaolT+SKTZ9zCohfBfGTrWR
         CoFLLu1b0cE+yqNC0RsN0W1KsADflRl5xcRocb7FCLns9u2RBrT7cD0rqjrgk/zQ1KAg
         pcfnVVtIQz0RzvpFG9+b1tslafYgh9u+idBYdvbeQOTcpCapriAb4uzT9v9LnY03nLDl
         5OsDcJicncXd9y/qlBFQHiW5VyTfJcknNEXP3ZgyZBMPAL3PD4MfYe7US4BIRDYIxYx1
         GT9AV0KAfwJvhqVX+Z4xdvveTYK29kNGDBc/l82vTE39ChaQip/folH61dWeldPH+M4V
         UEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uGAruIhfl5PbFQl3w9o1oFcfZ2mxOXPUkTfgPA5jlzw=;
        b=VPYFIc6YJzySkGQ1DPXQDMGGf40PZVifX0pMbq5rzfnDJJq9vmF9eYVzSpfpYgBK0m
         CC9piKlzWFukluoGBqN/cORIQi2zzgowaALErGJcut5crVpW1TWeeySqZ1CizVNVR6gf
         rZ6mWpeHBVnTQFCBHgtBBw+AsG0qljo8lErukOYjXQKBYOxRb2ZPnn1ElMSOOtPsU3Bz
         zZuAM8MKFcznDUYwGI4+RTOB2BTAeusFT6S2JA3nVwjNp7silcCMkmi58yVvsu8VRBUe
         liIRQ1r6H3/zm/7f8fTNsqGSEDYWKt9XAPnKvx63x/UWW4WRwaZVpdYK842Ckjtk8mM6
         ge8A==
X-Gm-Message-State: AOAM533BA/z0FL7zf56IXVdq3050SB4qn4UpGfn1KiibC3u6LW9Hk9I/
        qdP0NHoAfOH2hhzdCqKeJlai9OT2/ag2/aluTOSgGg==
X-Google-Smtp-Source: ABdhPJxQ3Z/ZfREoHYywLnOQ/u3hHNnqzho9PgITb0IZIEoLKXzVXkawh1zDbeXno8RDvzpLCkZYqbolcf03OLZQvmY=
X-Received: by 2002:a50:ff13:: with SMTP id a19mr29429964edu.300.1618888805732;
 Mon, 19 Apr 2021 20:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <e1a52da9aec90766da5de51b1b839fd95d63a5af.camel@intel.com> <BL0PR12MB25321D18363AD50ACC7A2643BD499@BL0PR12MB2532.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB25321D18363AD50ACC7A2643BD499@BL0PR12MB2532.namprd12.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 19 Apr 2021 20:19:56 -0700
Message-ID: <CAPcyv4jztOGShTF+pVSMAtGeK4giHvC3mGNa5bC0pXz=2ZcrJw@mail.gmail.com>
Subject: Re: [ACPI Code First ECN v2]: Generic Port, performace data for
 hotplug memory
To:     Vikram Sethi <vsethi@nvidia.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "Douglas, Chet R" <chet.r.douglas@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Thanu Rangarajan <Thanu.Rangarajan@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 19, 2021 at 3:56 PM Vikram Sethi <vsethi@nvidia.com> wrote:
[..]
> > * Replace all instances of "Initiator" with "Initiator / Port" in "Tabl=
e
> >   5.59 Flags - Generic Initiator Affinity Structure", including the
> >   table name.
>
> I wanted to discuss the implications of a CXL host bridge implementation =
that
> does not set the "Architectural Transactions" bit/flag in the aforementio=
ned
> Flags in Table 5.59.
>
> Since the kernel would be expecting all "System RAM" to have equivalent
> Functional properties, if HDM cannot have all the same functionality, the=
n in
> the absence of ISA specific ACPI tables clarifying what architectural fea=
ture isn't
> supported, the kernel may be forced to not online the HDM memory as syste=
m
> RAM. If there is more granular expression of what features are lacking in=
 a ISA
> Specific table (eg Memory Tagging/Memory Protection keys not supported),
> the kernel could choose to not enable that feature in all of system RAM (=
if
> discrepancy discovered at boot), but still online the HDM as System RAM.
>
> To that end, it may be useful to clarify this to host vendors by way of a=
n
> Implementation note (ideally in the CXL specification). Something like:
> "CXL hosts are encouraged to support all architectural features in HDM
> as they do in CPU attached memory to avoid either the memory from
> being onlined as System RAM, or the architectural feature being disabled.
> Hosts must indicate architectural parity for HDM in ACPI SRAT
> =E2=80=9CGeneric Port=E2=80=9D flags =E2=80=9CArchitectural transactions=
=E2=80=9D bit by setting it to 1.
> A port that sets this bit to 0 will need ISA specific ways/ACPI tables to
> describe which specific ISA features would not work in HDM, so an OS
> could disable that memory or that feature."
>
> Thoughts?

The problem, as you know, is that those features are already defined
without those "ISA specific ways / ACPI tables". I think it simply
must be the case that the only agent in the system that is aware of
the intersection of capabilities between ISA and CXL (platform
firmware) must mitigate the conflict. I.e. so that the CXL
infrastructure need not worry about ISA feature capability and vice
versa. To me, this looks like a platform firmware pre-boot
configuration menu / switch that turns off CXL (declines to publish
ACPI0016 devices) if incompatible ISA feature "X" is enabled, or the
reverse turns off ISA feature "X" if CXL is enabled. In other words,
the conflict needs to be resolved before the OS boots, setting this
bit to 0 is not a viable option for mitigating the conflict because
there is no requirement for the OS to even look at this flag.
