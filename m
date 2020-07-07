Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BA3217448
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jul 2020 18:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgGGQnc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Jul 2020 12:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgGGQnb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jul 2020 12:43:31 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB78C061755
        for <linux-acpi@vger.kernel.org>; Tue,  7 Jul 2020 09:43:31 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so16959738plo.7
        for <linux-acpi@vger.kernel.org>; Tue, 07 Jul 2020 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0CvFCRMGyH8ng1oyUVoBZbdUNhkgtcfr8Mw5rYPl6rU=;
        b=Ip4JCRO9Uih6Knc+6wGL010irBJegJQlega20oXZD3gAVz3Gd96yQRvs7kaA3fNjV/
         z/ZAGWVhhJjrmk34h9KVXeuOIaYj72kuKRWPEmYv0R0iY8LFuVS0z7DbSvF+HjQ08l8A
         oUg6MlEKkSCh78v9cDkJ55Qm4t2hysgVyhapX2iKObx3m4a9jLTUV4GbWVHNpjEBVQ7g
         AoodoW9ix66XSZBcf3u0ldo/kMtkd+FX2uNLw0LKtcOLgt3rvi3VrFUbKkw7DCoVNXDV
         LQ8I03Yti0ZM6SiXfhQ91ml5lPQYcGroauyF+5ECCGLjPgQWmZo3E521xeqU+AadU+jf
         ckLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0CvFCRMGyH8ng1oyUVoBZbdUNhkgtcfr8Mw5rYPl6rU=;
        b=QFx309dNhmG+ENihJA161hONSlFdS0e5SRVyiJrN8Nvdrcvmxda/lr1lQY3s6lQNUh
         xT2fAKA5v1HByvjsztrIYWtmULMhZQvK7PfM6lHYxhwGAjTQTL7QEo5Tq0/VVZ+TZQAm
         Vp0OmCYaS4kbcSdhU69aeskCgpCZco0BHpqO3Juxw2jpihG8xQBcKggXVVn1beyhC+sq
         zAGldiGP2r8uurQwIuJTFU0obclhztBia7xf80Jraur2pwruTrg+SyDM5qHydb9PZEWc
         UwTrTzQedfUSnIOcadX+8HtLdW++qIOuiveV5Wv2oLbeOqKvrHytYyNYeC5g05BpksoE
         i6bw==
X-Gm-Message-State: AOAM530kM2V09kvzc4KlIshjdSNPFDvdwStBwUz+oIYrtZbN9ldOpb2g
        PTHRUWeIF7UZnfwJtEoYl9nU+w==
X-Google-Smtp-Source: ABdhPJwwBLoiCnrjwRhFJQYWj+jTUZqOBr3HuHyo0/STACqPViLc8hndgtf6CrLI/HtLg7tjT5bZ0A==
X-Received: by 2002:a17:90a:1089:: with SMTP id c9mr5346227pja.180.1594140210827;
        Tue, 07 Jul 2020 09:43:30 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
        by smtp.gmail.com with ESMTPSA id n12sm1392859pgr.88.2020.07.07.09.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 09:43:29 -0700 (PDT)
Date:   Tue, 7 Jul 2020 09:43:25 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>, wsd_upstream@mediatek.com
Subject: Re: [PATCH v2] cpuidle: change enter_s2idle() prototype
Message-ID: <20200707164325.GA2525978@google.com>
References: <1594005196-16327-1-git-send-email-neal.liu@mediatek.com>
 <1594005196-16327-2-git-send-email-neal.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594005196-16327-2-git-send-email-neal.liu@mediatek.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 06, 2020 at 11:13:16AM +0800, Neal Liu wrote:
> Control Flow Integrity(CFI) is a security mechanism that disallows
> changes to the original control flow graph of a compiled binary,
> making it significantly harder to perform such attacks.
> 
> init_state_node() assign same function callback to different
> function pointer declarations.
> 
> static int init_state_node(struct cpuidle_state *idle_state,
>                            const struct of_device_id *matches,
>                            struct device_node *state_node) { ...
>         idle_state->enter = match_id->data; ...
>         idle_state->enter_s2idle = match_id->data; }
> 
> Function declarations:
> 
> struct cpuidle_state { ...
>         int (*enter) (struct cpuidle_device *dev,
>                       struct cpuidle_driver *drv,
>                       int index);
> 
>         void (*enter_s2idle) (struct cpuidle_device *dev,
>                               struct cpuidle_driver *drv,
>                               int index); };
> 
> In this case, either enter() or enter_s2idle() would cause CFI check
> failed since they use same callee.
> 
> Align function prototype of enter() since it needs return value for
> some use cases. The return value of enter_s2idle() is no
> need currently.
> 
> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> ---
>  drivers/acpi/processor_idle.c   |    6 ++++--
>  drivers/cpuidle/cpuidle-tegra.c |    8 +++++---
>  drivers/idle/intel_idle.c       |    6 ++++--
>  include/linux/cpuidle.h         |    6 +++---
>  4 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 75534c5..6ffb6c9 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -655,8 +655,8 @@ static int acpi_idle_enter(struct cpuidle_device *dev,
>  	return index;
>  }
>  
> -static void acpi_idle_enter_s2idle(struct cpuidle_device *dev,
> -				   struct cpuidle_driver *drv, int index)
> +static int acpi_idle_enter_s2idle(struct cpuidle_device *dev,
> +				  struct cpuidle_driver *drv, int index)
>  {
>  	struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
>  
> @@ -674,6 +674,8 @@ static void acpi_idle_enter_s2idle(struct cpuidle_device *dev,
>  		}
>  	}
>  	acpi_idle_do_entry(cx);
> +
> +	return 0;
>  }
>  
>  static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
> index 1500458..a12fb14 100644
> --- a/drivers/cpuidle/cpuidle-tegra.c
> +++ b/drivers/cpuidle/cpuidle-tegra.c
> @@ -253,11 +253,13 @@ static int tegra_cpuidle_enter(struct cpuidle_device *dev,
>  	return err ? -1 : index;
>  }
>  
> -static void tegra114_enter_s2idle(struct cpuidle_device *dev,
> -				  struct cpuidle_driver *drv,
> -				  int index)
> +static int tegra114_enter_s2idle(struct cpuidle_device *dev,
> +				 struct cpuidle_driver *drv,
> +				 int index)
>  {
>  	tegra_cpuidle_enter(dev, drv, index);
> +
> +	return 0;
>  }
>  
>  /*
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index f449584..b178da3 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -175,13 +175,15 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
>   * Invoked as a suspend-to-idle callback routine with frozen user space, frozen
>   * scheduler tick and suspended scheduler clock on the target CPU.
>   */
> -static __cpuidle void intel_idle_s2idle(struct cpuidle_device *dev,
> -					struct cpuidle_driver *drv, int index)
> +static __cpuidle int intel_idle_s2idle(struct cpuidle_device *dev,
> +				       struct cpuidle_driver *drv, int index)
>  {
>  	unsigned long eax = flg2MWAIT(drv->states[index].flags);
>  	unsigned long ecx = 1; /* break on interrupt flag */
>  
>  	mwait_idle_with_hints(eax, ecx);
> +
> +	return 0;
>  }
>  
>  /*
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index ec2ef63..bee10c0 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -66,9 +66,9 @@ struct cpuidle_state {
>  	 * suspended, so it must not re-enable interrupts at any point (even
>  	 * temporarily) or attempt to change states of clock event devices.
>  	 */
> -	void (*enter_s2idle) (struct cpuidle_device *dev,
> -			      struct cpuidle_driver *drv,
> -			      int index);
> +	int (*enter_s2idle)(struct cpuidle_device *dev,
> +			    struct cpuidle_driver *drv,
> +			    int index);
>  };
>  
>  /* Idle State Flags */
> -- 
> 1.7.9.5

This looks good to me, thank you for sending the patch! Please feel free
to add:

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
