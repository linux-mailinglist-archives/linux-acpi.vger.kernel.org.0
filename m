Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60BD9712E4
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jul 2019 09:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732658AbfGWHah (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Jul 2019 03:30:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37968 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732657AbfGWHah (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Jul 2019 03:30:37 -0400
Received: by mail-ot1-f65.google.com with SMTP id d17so43094616oth.5;
        Tue, 23 Jul 2019 00:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FpJgzT+7tUT7ple40No6kP66YV3ZkuZw7itpAewQ1tQ=;
        b=cY2FHoxLf3UFfl30MdO2WT7feOR5BXJL3ZKXU4c2Y7aIm4e+T7E3A4YNy0tsRoi6a4
         AA4MZM5/iWL1bb+wUhPEUOXbdfTi6cXgks86yryURiI2/oW60JMJwx4qDG7+BBDpdmaj
         Pa//eU9C8beaizKujSwSuOxBAY0uhLVvVxrWIF7IYiKmc7+1Gv7EHvh/ng4DFs9JD74x
         ++OJ4vJhM/O5vI8Vc/WiyP7G/yOAIjrIy6dGX2A2OUH4WsRzMGoLa9xcckgUunD4rF7e
         YFq35IqE6Be/XJ2xwCeqRYP2oi0jXBVqh9T8QOYyv9jq+fjh3gJ6IkvNLCPXsCS28GqL
         SXjg==
X-Gm-Message-State: APjAAAV4Jo+Nvg2E6Nxm+BfRfKYbxVVdjCelOtBOY91rcL9Lm5KNaS+P
        J05KKS1mUecRu5WxPuuy/9hoTAmlLe7KeWsgsTcxLc37
X-Google-Smtp-Source: APXvYqxcNJEOwGJB5fN/m/YmcCoj2DjhHm7l4wYdY7E78+ZG6LP01279MnFvvYZKIn3S3COvsmviOod7hgVpgxr6ZFA=
X-Received: by 2002:a05:6830:8a:: with SMTP id a10mr26026736oto.167.1563867036041;
 Tue, 23 Jul 2019 00:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <3270289.QqOHTbhTGK@kreacher>
In-Reply-To: <3270289.QqOHTbhTGK@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Jul 2019 09:30:22 +0200
Message-ID: <CAJZ5v0ik4b0LZ_WwscvZ_WibaN89DWCy-J1KZCJCCkh5TiGXAg@mail.gmail.com>
Subject: Re: [PATCH] int340X/processor_thermal_device: Fix proc_thermal_rapl_remove()
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 22, 2019 at 12:23 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Passing 0 to cpuhp_remove_state() triggers the BUG_ON() in
> __cpuhp_remove_state_cpuslocked() and the argument passed to
> powercap_unregister_control_type() is expected to be a valid
> pointer, so avoid calling these functions with incorrect
> arguments from proc_thermal_rapl_remove().
>
> Fixes: 555c45fe0d04 ("int340X/processor_thermal_device: add support for MMIO RAPL")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Any comments?

If not, I'll queue this up along with the other RAPL-related fix
(https://patchwork.kernel.org/patch/11050999/).

> ---
>  drivers/thermal/intel/int340x_thermal/processor_thermal_device.c |    4 ++++
>  1 file changed, 4 insertions(+)
>
> Index: linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++ linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -487,6 +487,7 @@ static int proc_thermal_rapl_add(struct
>                                 rapl_mmio_cpu_online, rapl_mmio_cpu_down_prep);
>         if (ret < 0) {
>                 powercap_unregister_control_type(rapl_mmio_priv.control_type);
> +               rapl_mmio_priv.control_type = NULL;
>                 return ret;
>         }
>         rapl_mmio_priv.pcap_rapl_online = ret;
> @@ -496,6 +497,9 @@ static int proc_thermal_rapl_add(struct
>
>  static void proc_thermal_rapl_remove(void)
>  {
> +       if (IS_ERR_OR_NULL(rapl_mmio_priv.control_type))
> +               return;
> +
>         cpuhp_remove_state(rapl_mmio_priv.pcap_rapl_online);
>         powercap_unregister_control_type(rapl_mmio_priv.control_type);
>  }
>
>
>
