Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406474EFBB8
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Apr 2022 22:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352519AbiDAUmO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Apr 2022 16:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352104AbiDAUmM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Apr 2022 16:42:12 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB569174BB3;
        Fri,  1 Apr 2022 13:40:22 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9CB6E820B4D;
        Fri,  1 Apr 2022 20:40:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a229.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 18F748204B4;
        Fri,  1 Apr 2022 20:40:21 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1648845621; a=rsa-sha256;
        cv=none;
        b=Th35VL62JoMGFVR/RNMt3ic4IDKLk+nRShdM70Cy6sUMqLpA0UEJVLZspx0+dHC0prPwEN
        YgluXIp+qM6B85JXuZOCb5r6TXo5f5liSe7cAT9EoysjuDQ0J3v0TkA8JWUhNsf3MzWc1P
        LOuwWwDlq8FjplJQKcINpkmcizv3Q+fCBNBz26gMXmZCatSfJ+jmzkdPs91pio9bTRjvIg
        zg7s+QVcOMCiReUjrLK7Qb4KoZ9d+o9+pdBf5sCYJkYghQHx92lA9mdKSbhKt+lrRzL+/P
        ub/P+pxY+CIj1yWiTprqFXEhC4JFwXCeE3W1WHKekVzkFsEwiFNluamiwkjagg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1648845621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=PNKd6vhVfX5oDucS9KT/jNMGz7RGqoHUqWq18NXpaIE=;
        b=ZLcDQLeUU+LQxevT+0k648kLwNCY18x71JvGFigWEXWjgNIXM7XzJUlkqGYrV6NOUQ1VUs
        nw0yyaKvQz0N4asUb+caNGTBSp0GqR3eYdRJPZfoevp6D1BvcyMhGP765FcjNJM7LCj5aj
        ao/YMoHIXgXNNQ5nPTlCKR51QMNdfAKqVddSRkhJpw4bXQaVsRKK2f+zqMkkpbhYc6F4i7
        5DPCXd9gj8QOew8DkwPuuh9AC7n768sm9jcHBgGj/ZrW9DW7N0HDhRNaXRxwNhzWuNGTXd
        mrm9qzhKalvfvktEMsZ3+eRpi34mCLxJCYokti1CWVlREFH2YIDREUXB91A44g==
ARC-Authentication-Results: i=1;
        rspamd-f76767c84-qrhsc;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a229.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.115.45.15 (trex/6.7.1);
        Fri, 01 Apr 2022 20:40:21 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lonely-Absorbed: 52f960c07c29bade_1648845621473_2287563284
X-MC-Loop-Signature: 1648845621472:3802283897
X-MC-Ingress-Time: 1648845621472
Received: from offworld (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a229.dreamhost.com (Postfix) with ESMTPSA id 4KVX9Y4f8lz21;
        Fri,  1 Apr 2022 13:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1648845618;
        bh=PNKd6vhVfX5oDucS9KT/jNMGz7RGqoHUqWq18NXpaIE=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Q9wJbFhPdS0bMDdwFleZVVsXFj/UWby9K6CBGuKGps4U4n1jnm6AJTvqXMIy92mBr
         VTTVwAXLXQcNx35+Gj/0OWtbxqQYLkqDkwW5R5qbwFANW46grf2ILioAP8uhjhwtjb
         08YiyFEPgtm+aMxkSn/amKBO2mhuCg0fPtbuBfem15d7ztTdTpxnzKdpgdCS+Dbi3S
         r0cgfMe7O54cMjIGuahoJQzAJCsQum4fseQ0FK9XFflI3OVw53tMOjzfYNZaBAhNgF
         pC12OQ+P8PUQQ81MvSt2HV+19XJDCLSBtBzVFNbg14hSlWXvMd/9gyesxqG9nAFc8Q
         j+9dn/ZpQbpOA==
Date:   Fri, 1 Apr 2022 13:40:14 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 3/3] PCI/ACPI: negotiate CXL _OSC
Message-ID: <20220401204014.khgozoeu6biirknu@offworld>
References: <20220331202022.1823174-1-vishal.l.verma@intel.com>
 <20220331202022.1823174-4-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220331202022.1823174-4-vishal.l.verma@intel.com>
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

On Thu, 31 Mar 2022, Vishal Verma wrote:

>The CXL specification does not define any additional constraints on
>the hotplug flow beyond PCIe native hotplug, so a kernel that supports
>native PCIe hotplug, supports CXL hotplug.

Hmm but from a Linux-pov does it make sense to allow hotplug
support if the MM cannot handle it?

@@ -531,7 +518,8 @@ static u32 calculate_cxl_support(void)
	support = OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT;
	if (pci_aer_available())
		support |= OSC_CXL_PROTOCOL_ERR_REPORTING_SUPPORT;
-       if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
+       if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE) &&
+           IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
		support |= OSC_CXL_NATIVE_HP_SUPPORT;

	return support;

After all, per the CXL 2.0 Type 3 device Hot-Add flow:

""
7. CXL aware software notifies OS memory manager about the new memory and its
attributes such as latency and bandwidth. Memory manager processes a request
and adds the new memory to its allocation pool.
""

Thanks,
Davidlohr
