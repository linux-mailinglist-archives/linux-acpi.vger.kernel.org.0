Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A328A55CBF7
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jun 2022 15:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238268AbiF0Luk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Jun 2022 07:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238458AbiF0Lss (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jun 2022 07:48:48 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0B3CE2E
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jun 2022 04:42:33 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id fi2so18522164ejb.9
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jun 2022 04:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U96yknaouPbBJnn6hQmbtloh8lKJEQa8m942bJHa948=;
        b=gR09IPhQCrv3LwR2L7BZnlde8fwVSTkEfqgZYCg+h1/8OnDr3nZee0MNthTw6HlGrY
         2AQrJ0g+oPw8+luhOr0iDZuRW0ybwzVsyCnlXbiaED7GgzAcjvqlGB3nmH6OXcDPAscz
         tW+tnXzlhE8BHKI0oYgKTq+r//qbVVvmJMk1DZsl3RTTp6OK6s5/HrwEi9XzrVNUKZsF
         byyfBDxPRQwrDuZpkIhu114h7eljFiRRKBQWHoRACyC/PbjHheqf4037fa429yoPP/ob
         SOVHl11OyPz56nCmN7dnP0jEk58sZhsKLu5xM21ssBip7ookihOyAU34qcO0jLMc5O4d
         Seuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U96yknaouPbBJnn6hQmbtloh8lKJEQa8m942bJHa948=;
        b=kLEV57ALUDexSttfDVhDk0mqV4SVOS5YlvEK41ILYLqDSKiXTC9noo0ypLm7lPztlL
         4v/mN8SALA8b6Oht+ZsSfmTpKGZlNXmnaHyLlbTMQBMLJyNrCe1S0Yp/e9drsgSK/MM7
         PM/2/hGAMbqCOEotcKxfO3S7FGnsD3Nc3B2rKLs3/twD3x6heExfVqZq3FnNOZXEhP38
         jj6GiaTdBcf8Z7j8Dgo/C/eMkkEYhzTZEAQkVzVUcpc8mXaWQHF5KipEvTiaNPCnz/wZ
         TN2y+G3hbBdeTy0KBB2NYFTyP9FHiqAxMuuvy6P92mnH08ZY+o66pNZ6ePGTwWvR2bOA
         VALg==
X-Gm-Message-State: AJIora+PQ34/Th5e8PYxmY2oLQOMyiw863oB7MA7eMIsrnBR6tXFdmKr
        dKWhQMDhKBSJv9ADi/ccEvzbCmhA8DU1Ng==
X-Google-Smtp-Source: AGRyM1u2TvQPgd533Q8/sOg471TCJvIlg4REDbqbfTzwcOpw2EpWH6A0ulTqXsYQiaAvbj9MCmB8aw==
X-Received: by 2002:a17:907:3f82:b0:726:3732:961c with SMTP id hr2-20020a1709073f8200b007263732961cmr12757395ejc.727.1656330151600;
        Mon, 27 Jun 2022 04:42:31 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id x10-20020a170906298a00b00722e8f4b459sm4984948eje.93.2022.06.27.04.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 04:42:31 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:42:29 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        kernel-team@android.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 13/17] driver core: Use device's fwnode to check if it
 is waiting for suppliers
Message-ID: <YrmXpcU1NTYW6T/n@linaro.org>
References: <20201121020232.908850-1-saravanak@google.com>
 <20201121020232.908850-14-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121020232.908850-14-saravanak@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 20-11-20 18:02:28, Saravana Kannan wrote:
> To check if a device is still waiting for its supplier devices to be
> added, we used to check if the devices is in a global
> waiting_for_suppliers list. Since the global list will be deleted in
> subsequent patches, this patch stops using this check.
>
> Instead, this patch uses a more device specific check. It checks if the
> device's fwnode has any fwnode links that haven't been converted to
> device links yet.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 395dece1c83a..1873cecb0cc4 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -51,6 +51,7 @@ static DEFINE_MUTEX(wfs_lock);
>  static LIST_HEAD(deferred_sync);
>  static unsigned int defer_sync_state_count = 1;
>  static DEFINE_MUTEX(fwnode_link_lock);
> +static bool fw_devlink_is_permissive(void);
>
>  /**
>   * fwnode_link_add - Create a link between two fwnode_handles.
> @@ -995,13 +996,13 @@ int device_links_check_suppliers(struct device *dev)
>  	 * Device waiting for supplier to become available is not allowed to
>  	 * probe.
>  	 */
> -	mutex_lock(&wfs_lock);
> -	if (!list_empty(&dev->links.needs_suppliers) &&
> -	    dev->links.need_for_probe) {
> -		mutex_unlock(&wfs_lock);
> +	mutex_lock(&fwnode_link_lock);
> +	if (dev->fwnode && !list_empty(&dev->fwnode->suppliers) &&
> +	    !fw_devlink_is_permissive()) {
> +		mutex_unlock(&fwnode_link_lock);

Hi Saravana,

First of, sorry for going back to this.

There is a scenario where this check will not work and probably should
work. It goes like this:

A clock controller is not allowed to probe because it uses a clock from a child device of a
consumer, like so:

	dispcc: clock-controller@af00000 {
        	clocks = <&dsi0_phy 0>;
	};

	mdss: mdss@ae00000 {
		clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>;

		dsi0_phy: dsi-phy@ae94400 {
        		clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
		};
	};

This is a real scenario actually, but I stripped it down to the essentials.

So, the dsi0_phy will be "device_add'ed" (through of_platform_populate) by the mdss probe.
The mdss will probe defer waiting for the DISP_CC_MDSS_MDP_CLK, while
the dispcc will probe defer waiting for the dsi0_phy (supplier).

Basically, this 'supplier availability check' does not work when a supplier might
be populated by a consumer of the device that is currently trying to probe.


Abel


>  		return -EPROBE_DEFER;
>  	}
> -	mutex_unlock(&wfs_lock);
> +	mutex_unlock(&fwnode_link_lock);
>
>  	device_links_write_lock();
>
> @@ -1167,10 +1168,7 @@ static ssize_t waiting_for_supplier_show(struct device *dev,
>  	bool val;
>
>  	device_lock(dev);
> -	mutex_lock(&wfs_lock);
> -	val = !list_empty(&dev->links.needs_suppliers)
> -	      && dev->links.need_for_probe;
> -	mutex_unlock(&wfs_lock);
> +	val = !list_empty(&dev->fwnode->suppliers);
>  	device_unlock(dev);
>  	return sysfs_emit(buf, "%u\n", val);
>  }
> @@ -2202,7 +2200,7 @@ static int device_add_attrs(struct device *dev)
>  			goto err_remove_dev_groups;
>  	}
>
> -	if (fw_devlink_flags && !fw_devlink_is_permissive()) {
> +	if (fw_devlink_flags && !fw_devlink_is_permissive() && dev->fwnode) {
>  		error = device_create_file(dev, &dev_attr_waiting_for_supplier);
>  		if (error)
>  			goto err_remove_dev_online;
> --
> 2.29.2.454.gaff20da3a2-goog
>
>
