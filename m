Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27584708CF7
	for <lists+linux-acpi@lfdr.de>; Fri, 19 May 2023 02:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjESAeK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 May 2023 20:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjESAeJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 May 2023 20:34:09 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42B9115
        for <linux-acpi@vger.kernel.org>; Thu, 18 May 2023 17:34:07 -0700 (PDT)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B838B3F235
        for <linux-acpi@vger.kernel.org>; Fri, 19 May 2023 00:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684456445;
        bh=S3vX5E2MUkA/GLgXx8mlZrX2TR651WDCn5VRkdDwcW0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=jigWFl6eA/tRdV5znkOUuezv6HjwbaoEpVip/HDqXTJP2fCULJ3Gx6waML03++2jB
         Wh2k1umL4n0pMRgxPGC6v0u9CwOZn/fsY+RxGuQ6k0BHGJKvCyjahYQMpNf8YdxmGp
         gzUxS74L49nthNoD5eTtD4VU3sIVKR1v+dm8eP07cTj8ye+zffnp24NF05Mei4vQQh
         9ioEE5E0yAHopL/0pz36nMKtGhzeS6MQTQ6W5aK/WedDmICtvx44sFmYqZKCCS/di6
         93T+fW4R2bAkIMdG0Q5cph6hqURFBI7rMniJtRwsYg6uWZ+dVy8MHWC5Obo8goxhTn
         BD6jDpfUrmXhw==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6435b907f46so1706613b3a.1
        for <linux-acpi@vger.kernel.org>; Thu, 18 May 2023 17:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684456444; x=1687048444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3vX5E2MUkA/GLgXx8mlZrX2TR651WDCn5VRkdDwcW0=;
        b=XieJqlkIHca9/Wc3AdBjbUL3SwWn3i1SP+GI0bOoax2TU+7HUNOA8K6OdOPkBgMNfQ
         RHOLTloUSMhbaeZtwxlFHXlstVVSIYvhCtPiP7FuUA5hBWMpqUl00WvrbyZ/qIP2lcxD
         oYqDToj0BDkZCleuuuZDd+hheAVtuXHo0tC1sUFVmDvqOtD4hbSjBBOsKF9NShODqds7
         YhdtTU5aoWotyy+zUFhl/3ojsAstjgheNMv3TMqC9lfGdVw+tCoWltK7WoaVwxdyXW+p
         xKpbMvS28O/u1KVyoFQ8vZ2Cl3ez+ztnA7cVpLgIQSi8iiDYDIJlENZCqmaxXsZUOBt2
         HZXg==
X-Gm-Message-State: AC+VfDxVwgqqpGWJz0oOhZSR80GSJKpwu+M//eCvzNSxYUlNqfR7yzI9
        8wlMhDUuxiwXoIsTSc+qCzoxihy8jzq290Vdf/a9W8nsPBZlMi52mT1zcUuKrShMZPFILy9Nma1
        JDFQb9O30JN6qCwzmwQiJ9GpCfT0WOlsra/FX8EdmvVllNtniGi4+e1SZbVJuLXE=
X-Received: by 2002:a05:6a20:100d:b0:f0:9cbd:78e3 with SMTP id gs13-20020a056a20100d00b000f09cbd78e3mr317093pzc.0.1684456444122;
        Thu, 18 May 2023 17:34:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ZXq0RckIUB8crrJ3/oplkji1hjrmAa0mi119eZo4En33YfA5uoxgPbheYoT0Ka2aUyz2vP1Kp8Td37BsUMio=
X-Received: by 2002:a05:6a20:100d:b0:f0:9cbd:78e3 with SMTP id
 gs13-20020a056a20100d00b000f09cbd78e3mr317074pzc.0.1684456443725; Thu, 18 May
 2023 17:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <2e46e535-32cf-d2b8-6e22-497aa4e66287@linux.intel.com>
In-Reply-To: <2e46e535-32cf-d2b8-6e22-497aa4e66287@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 19 May 2023 08:33:51 +0800
Message-ID: <CAAd53p7U36MpT3E6LPX1KUj6-j_u=Hy1TfNGbaR-Bp+GT8MoJw@mail.gmail.com>
Subject: Re: Issue with Upstream patch "PCI: vmd: Honor ACPI _OSC on PCIe features"
To:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Cc:     rafael@kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[+Cc linux-acpi]

Hi Nirmal,

On Thu, May 18, 2023 at 11:37=E2=80=AFPM Patel, Nirmal
<nirmal.patel@linux.intel.com> wrote:
>
> Hello,
>
> I am writing this email to report an issue we are observing
> because of recent addition of a patch and need some help
> understanding it better.
>
> Issue:
> Drives are still present after performing hotplug in guest
> OS. We have tested with different combination of OSes, drives
> and Hypervisor. The issue is present across all the OSes and
> the following patch was identified as a root cause.
>
> This patch was added to avoid AER messages for Samsung
> drives when VMD is enabled.

To be more specific, the patch is to align with what other OSes do on
the VMD ports.

>
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/dr=
ivers/pci/controller/vmd.c?id=3D04b12ef163d10e348db664900ae7f611b83c7a0e
>
> I also compared the values of the parameters in the patch
> in Host and Guest OS. The parameters with different values
> in Host and Guest OS are:
>
> native_pcie_hotplug
> native_shpc_hotplug
> native_aer
> native_ltr
>
> I am not sure why "native_pcie_hotplug" is changed to 0 in guest.
> Isn't it OSC_ managed parameter? If that is the case, it should
> have same value in Host and Guest OS.

Assuming it's a VM and NVMe passthrough? I guess guest OS provide its
own _OSC value?

>
> Can you please provide your input or next step?

Please file a bug with both host and guest OS's `dmesg` and `lspci
-vv` attached.

> Is reverting the patch a good option?

Not really...

Kai-Heng

>
> Thank you for your time.
>
> Regards,
> -Nirmal
>
