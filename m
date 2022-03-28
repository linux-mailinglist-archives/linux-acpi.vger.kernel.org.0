Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7974E9F04
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Mar 2022 20:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245196AbiC1ShD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Mar 2022 14:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244552AbiC1ShC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Mar 2022 14:37:02 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500CC5F8F7;
        Mon, 28 Mar 2022 11:35:21 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 314086C1314;
        Mon, 28 Mar 2022 18:35:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a309.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 394B66C0E48;
        Mon, 28 Mar 2022 18:35:19 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1648492519; a=rsa-sha256;
        cv=none;
        b=V28caSIK4b85SQIZlS30LF9L9BW5DuYt7feIEQ2OZbERXUgxqJHzAHQ4FJWWHRTmDn3be0
        NWa0d/lh5P691CMh7M138GYDiJ4Df9omRZMe7c682u0v2XbgGeHI56G1E14LngBwfItjB9
        ogZd7Vv9kfn9iIHgYj/jG0RI7xp+JJIP3BxCvIymF2RNU4mSOszqXc/POT8ZVGVomCldR9
        LUfQesvVNV4E0SDKF2RaH1gd8kSCTsd0OW6rq8xMBC09Iplc1ylTOIGxtxEJCsYmjo9Oz4
        2pG1k4FSjgyTzX+qiZZYXRvovIgrOJD9Ch52+hMvsOrf/TjByGSpcFYj4VbYKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1648492519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=+LwR9XM7nn2KjJ5ioACBTs4tCSOjHpnltPxcDf9ugF0=;
        b=1sEQDg3COF82UIZ4zERtK3gHf9iK6nd91cswAIVk4TyKs58BNCrJ8OfQwpcfzTJnZSEtLB
        OJ1fT7vHNuf67ojQMJSxYSfj3iyQWH/LagepEBsRn88ElrZc0LYWndfftlgUj/SjUMfx/g
        Zfg/ZO8WI6i1cfmQYZCLQzQMMcLVCprf3BarBORhto5eJ1DB7W6ks5reYThM8Vgqp5Tpr0
        nNGKGFjrRBg65FcJ298Ruj4whUOyX3eF7GEHnRqUAGdDS0G4xhpl9ImpK+rdq/MOoq2hMz
        1skrffdpM/Sid7/YzxpYtVfwphSTVNKfg3hRFdd8ey+tAC9D4OxcsUnHLoIIQQ==
ARC-Authentication-Results: i=1;
        rspamd-5d5c987fbc-kzm8l;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a309.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.106.72 (trex/6.5.3);
        Mon, 28 Mar 2022 18:35:20 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Supply-Troubled: 19a13f596d42925f_1648492519610_2619772353
X-MC-Loop-Signature: 1648492519610:2872833501
X-MC-Ingress-Time: 1648492519609
Received: from offworld (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a309.dreamhost.com (Postfix) with ESMTPSA id 4KS1bB2mGFz47;
        Mon, 28 Mar 2022 11:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1648492519;
        bh=+LwR9XM7nn2KjJ5ioACBTs4tCSOjHpnltPxcDf9ugF0=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=I2G+aRM3y56gewF1+AubfPuYSMIXRb0SmBHfaqCqssGBDIuY8tjGi5nIZFnTbLblA
         GVyIuTrxcXSoo5QKf0/yGX8dho4r1kVQodCIEgOKucn5qL5J7WcBvNr9x0uPhlaG6z
         mI5TIOc4r5sWx8+RgyQg4KEXyg6uYDzur7CUnScLQ7yhaQCFdxQNUBuo4m78QQU5V1
         iJZ/fsgvyd67oodjylBi/O1z6MrN9GCw+ZmOP8GOnKrZ6DK5EXgDwy1KTgVtShT9Au
         4G3Zz+DPlGhsbPBFlSaKrU04bYgikIFTi2M9JZe6Tegwx8s+ILAq/Ehl7eSK3DcFhZ
         rV8n8K+ikf+KA==
Date:   Mon, 28 Mar 2022 11:35:15 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/2] PCI/ACPI: Use CXL _OSC instead of PCIe _OSC
Message-ID: <20220328183515.nk3e3tr5ecn2amzf@offworld>
References: <20220326002430.797244-1-vishal.l.verma@intel.com>
 <20220326002430.797244-2-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220326002430.797244-2-vishal.l.verma@intel.com>
User-Agent: NeoMutt/20201120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 25 Mar 2022, Vishal Verma wrote:

>+static bool is_pcie(struct acpi_pci_root *root)
>+{
>+	if (root->bridge_type == ACPI_BRIDGE_TYPE_PCIE)
>+		return true;
>+	return false;
>+}
>
>-static acpi_status acpi_pci_run_osc(acpi_handle handle,
>+static bool is_cxl(struct acpi_pci_root *root)
>+{
>+	if (root->bridge_type == ACPI_BRIDGE_TYPE_CXL)
>+		return true;
>+	return false;
>+}

return root->bridge_type == TYPE
