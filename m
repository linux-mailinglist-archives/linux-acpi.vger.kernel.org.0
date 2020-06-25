Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DB520A5D0
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Jun 2020 21:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406468AbgFYT3d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Jun 2020 15:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406329AbgFYT3d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jun 2020 15:29:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00D4C08C5C1
        for <linux-acpi@vger.kernel.org>; Thu, 25 Jun 2020 12:29:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k1so3255667pls.2
        for <linux-acpi@vger.kernel.org>; Thu, 25 Jun 2020 12:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I9ClT0BtwxTVUpdHAGXR7o4i9yCNCPbrz/AYOJH6pSI=;
        b=Swc7w5wR/KkOZ3Uabcl4IdqEH4PlmqfGqhz6npLi9yrH3/qWxXHJ0Sy2DVst9s5KbP
         NAYro3yOaFKZgjrTX1oNReN5C31zG+RiVVEAURxPYJ9HQ8OHVASav2BLcumjj7OjlSCn
         kVmwFjRpGqvQHFkJ6oaz663CwIWZAH8f3Ce1kkpoq72m8EVapXsqGAFPU65RBtJlt63a
         OnE3UwIrLf8IPCzbeoj03kp5u4esU3xo5bOToi83ARu97UIDNYHKilzKIn3fxygG5FHr
         MgY70iWrUwEJXt+kIBncgDPH0OOcPdx7/RPvxfZN0w9jk6+cXGoieZ2bpfNMY3uUZWB6
         URZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I9ClT0BtwxTVUpdHAGXR7o4i9yCNCPbrz/AYOJH6pSI=;
        b=RwGo3QjNrr0MHEAzw/D6a4kuuavM2OckjqdaFCgS6WhCcaPZBg3AmiZ0d/E8YQ9KIg
         eJ6qWeDkpAr4YutYxjughKN9jmku3q1fbyFV/vneAQSvwCuKb04NdToKu5+r35UsDF1C
         bzzYWqNWQ08b/30Zl7VAq67/s0rWdyB40Ah0G7c67/y3xi9Gt/uC/0NLl99aixJcJpzA
         TEkDmoyz9ColDGIEpo1434liHU9XFqiLOInVR5YyNQBu307V8KbormZkE8VeaU8of39R
         CRSOMdrrLe3ArTFxqq13/6sJIsvX7vgp5GxqCPvPHb7oJh8Lx/lLCEf4DxaBzU5uJWCl
         cpDQ==
X-Gm-Message-State: AOAM531v36L1cYzM2KRpPsfujVTsv0qYpagKLcFoQ8Ec3ZgfMz2t99w6
        mOf88u+ubfW3xdq3CJAPwtfy/72Qg+DD9hwpLAo=
X-Google-Smtp-Source: ABdhPJygAKTAcmhOMvQ3jZQuSiPs0tRjJBr/ucFkeopIKgE3+k/feugeqefrAaH+f+WlOqg5x8IYMb57wlnqwepGVb0=
X-Received: by 2002:a17:902:b206:: with SMTP id t6mr33227017plr.262.1593113372296;
 Thu, 25 Jun 2020 12:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200625043538.25464-1-calvin.johnson@oss.nxp.com> <202006251802.jt5kabG7%lkp@intel.com>
In-Reply-To: <202006251802.jt5kabG7%lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Jun 2020 22:29:15 +0300
Message-ID: <CAHp75VcQwLwE1GMh+2Ht7p=Xa20mkTdGC2vt=bwNrr=G6SV1zg@mail.gmail.com>
Subject: Re: [net-next PATCH v1] net: dpaa2-mac: Add ACPI support for DPAA2
 MAC driver
To:     kernel test robot <lkp@intel.com>
Cc:     Calvin Johnson <calvin.johnson@oss.nxp.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jon <jon@solid-run.com>,
        Cristi Sovaiala <cristian.sovaiala@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@oss.nxp.com>,
        kbuild-all@lists.01.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 25, 2020 at 2:06 PM kernel test robot <lkp@intel.com> wrote:

>     50          } else if (is_acpi_node(dev->parent->fwnode)) {

Hmm... Is it a device or data node?

>     51                  device_for_each_child_node(dev->parent, dpmac) {
>   > 52                          status = acpi_evaluate_integer(ACPI_HANDLE_FWNODE(dpmac),
>     53                                                         "_ADR", NULL, &adr);
>     54                          if (ACPI_FAILURE(status)) {
>     55                                  dev_info(dev, "_ADR returned status 0x%x\n", status);
>     56                                  continue;
>     57                          } else {
>     58                                  id = (u32)adr;
>     59                                  if (id == dpmac_id)
>     60                                          return dpmac;
>     61                          }
>     62                  }

Can't you use

 adev = acpi_find_child_device(ACPI_COMPANION(dev->parent), dpmac_id, false);
 if (adev)
  return ...

?

>     63          }


-- 
With Best Regards,
Andy Shevchenko
