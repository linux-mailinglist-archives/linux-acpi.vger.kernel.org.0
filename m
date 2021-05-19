Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BE638972D
	for <lists+linux-acpi@lfdr.de>; Wed, 19 May 2021 22:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhESUCc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 May 2021 16:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbhESUCc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 May 2021 16:02:32 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C4BC061761
        for <linux-acpi@vger.kernel.org>; Wed, 19 May 2021 13:01:11 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id o5so7756407edc.5
        for <linux-acpi@vger.kernel.org>; Wed, 19 May 2021 13:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OlxoSwTyBGcIB+AvV2WfDn1g1Sf/3pWsJB/YRZB8SB8=;
        b=1dh0Q+cxVbEWRDmbm9CbH3FmdqIYJe8AQBGdaFSXXRTRAU50YTKYucb5bSElHQPTK1
         Lv7Cc8hcGY8Leks6KtL54P+GEsSL7ZzHs9Ys03+8y7Uo6LGzaBH5et1EMJpA6MqboF7d
         dzbjjXf0OOlXr3SgohVT+LZCuju7dgik6T+NVkiwR70FiBTjiTMyz6gW86PcTkuD2EIM
         SUYq4mZmDjcOp/FALakgTnus6G9wyiTUGTq7mi1Hq+k1Z6akiGnqyz6b58BCCLoRnfRV
         qsfACgNRDDs2QVQDf+3Tj3FfouX4mQcV45NPfvFPUl3SuhuIeA92MXc+/xVPADipFOwb
         W8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OlxoSwTyBGcIB+AvV2WfDn1g1Sf/3pWsJB/YRZB8SB8=;
        b=OMrsvtnfXtUuFr5ik6LSNhOCV1zaDtn6D3kKuhF5W2N+qmaV93z6YLFylvlU+6d+oJ
         kM7La0vJlwjiW7VDBX34rYFofiKPmJDSafm1yb0I0pUp3ZSeshT8HSxs+27SUzjHlt4Z
         eDm+453QGfEq3RZcbyUcRJPpXgBBiKcYOeK1lwf2Icg2eG9TEK4thZQKa5eyx5JSOcUn
         noFdqPQM7hBZ25yZ7s/e6szg5VWl4wYmWy/esn8qToFwpNZEy3q91Y13pr9QTGm5P6G4
         bQGo2bQQhsLISmDXrTw+Kpa9uLo7wRo5AMllZGRfVfIQCHQlPpkybF5z/PDcbzhFYmDx
         0AUw==
X-Gm-Message-State: AOAM5316xh29rG8hBTejvx6uBxmIYFsFxfJcdAJjFmwOjMob/sJlkt2y
        SoWfv/1Gq9SZixNsbPUHTArzAtEkI5dJsac+c7pBkQ==
X-Google-Smtp-Source: ABdhPJwBYagjUpaXpLq5SIcAJYpu2toyEqzEY8kfw4+9XLQVZ7jpoX+ib07aWV6cm4nAhKDYGUb4FOrk3VOFKfJnE30=
X-Received: by 2002:a05:6402:128f:: with SMTP id w15mr808464edv.354.1621454470538;
 Wed, 19 May 2021 13:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210415232610.603273-3-ben.widawsky@intel.com> <20210415232750.604112-1-ben.widawsky@intel.com>
In-Reply-To: <20210415232750.604112-1-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 19 May 2021 13:01:00 -0700
Message-ID: <CAPcyv4jRm5Xw650GPUWOjAJ8sDQfOZ3yq2gMpVGho39eawLXrg@mail.gmail.com>
Subject: Re: [PATCH 3/3] cxl/mem: Demarcate vendor specific capability IDs
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 15, 2021 at 4:27 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Vendor capabilities occupy 0x8000 to 0xFFFF according to CXL 2.0 spec
> 8.2.8.2.1 CXL Device Capabilities. While they are not defined by the
> spec, they are allowed and not "unknown". Call this detail out in the
> logs to let users easily distinguish the difference.
>
> v2: Should be greater than or equal to (Ben)
>
> Fixes: 8adaf747c9f0b ("cxl/mem: Find device capabilities")
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/mem.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index c05617b0ba4b..28c7c29567b3 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -939,7 +939,10 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>                         cxlm->memdev_regs = register_block;
>                         break;
>                 default:
> -                       dev_dbg(dev, "Unknown cap ID: %x (0x%x)\n", cap_id, offset);
> +                       if (cap_id >= 0x8000)
> +                               dev_dbg(dev, "Vendor cap ID: %x (0x%x)\n", cap_id, offset);
> +                       else
> +                               dev_dbg(dev, "Unknown cap ID: %x (0x%x)\n", cap_id, offset);

This wants the same %#x fixup that Vishal noted on patch2 [1], and I
think it would be useful to clarify that the second number is indeed
an offset: "Unknown cap_id: %#x offset: %#x\n"

[1]: http://lore.kernel.org/r/40063fe52fcaa066a42d352b13128b6762277542.camel@intel.com
