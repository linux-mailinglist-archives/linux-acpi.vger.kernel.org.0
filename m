Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094DC4E9F2B
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Mar 2022 20:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238632AbiC1SxG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Mar 2022 14:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245306AbiC1Sww (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Mar 2022 14:52:52 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D58A644F9;
        Mon, 28 Mar 2022 11:51:10 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8959C6A10E0;
        Mon, 28 Mar 2022 18:51:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a309.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0510F6A08E0;
        Mon, 28 Mar 2022 18:51:09 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1648493469; a=rsa-sha256;
        cv=none;
        b=BnAgFBTLkFbM4QMZLmb8bgqXeB6dUwq7ayWTkjd0H/Pzo4Tfoz3e2sTSl2lHy2cimZTeDb
        elT733PTk5dFK2G2+8azljaTXX89ORMuld4GxT0uz+Ol8YoACOO1RxqJJGL7yB6VTpxBiQ
        2Op7qG6PKJ7r8WY4Lwsq64gZ1I9p4VfA0Sh5AQHZPU+V+Vb1XuBvwW1J3niK+v1py1dyBj
        HZwxSdfOhn+71Z1lg2jdev3xUwGFYLr8jTTNq7WSBcX2z2D4eHLWBAcdgM0SVN6QNRw8wL
        jtRERp4KiYX8o5+jbsQcR+70xBWLUsm7alOpIlX5WFc4cPCy/lv422BzV/GQSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1648493469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=GZkwIzVVdmnypDDwGtH7mIlQTlaajPq1PyApyoaV2Bs=;
        b=Bqnxa0yI0n47JlAZfzM0gQ6MgXibiCMG9ExxLEz16I3gChKJHCLQrVMo64InRAyiRpUSML
        0Wg61osipp5QXFjN/NneefIPAK5bPZ3rGqWdATMzP8EHt87ADr324rs4D2R38yohJXaior
        8kqKWKxSWqJ267YdAWt/65M6+JOWyE4Y/0yW2ECxOkERLYhPZIXZgu8SpzuzR0DokqybT9
        aiRozqI94z8QNfXW+weNlJQpd2P6/u/utUizFqyUEMI+iI+lGq1RqF2BsaZAskJROIV0BL
        wUs5nDTjEyz1PTTqCDJDnTFWynaLCRU2RAc3MNOitb0tC6n4TvzZX4mErKW5Ng==
ARC-Authentication-Results: i=1;
        rspamd-5d5c987fbc-fk5qg;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a309.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.123.11 (trex/6.5.3);
        Mon, 28 Mar 2022 18:51:09 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Harmony-Battle: 51e9ba5c14ffa190_1648493469389_1366194881
X-MC-Loop-Signature: 1648493469389:3653919349
X-MC-Ingress-Time: 1648493469389
Received: from offworld (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a309.dreamhost.com (Postfix) with ESMTPSA id 4KS1xR6hzSzZQ;
        Mon, 28 Mar 2022 11:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1648493468;
        bh=GZkwIzVVdmnypDDwGtH7mIlQTlaajPq1PyApyoaV2Bs=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=rhuzch4QF7bj8c9EwEediDv1TAiPISWQgLK05IElYkoqANzglX6urBbWGyVzNnEtN
         EARhbSF9NpPFkLzdk13OvDzWS2FrF7N8AvXiXOd2/Y/OLPRp+29Kh+tDFQB2Jo+6hE
         rGZBCxsgx0DKRg/ushZR5pxRqjkEQ46KdV/METtp8RjkakZq0Yau1L77lypa1o23Kn
         zOEBejOW4uIO2L1Zi6ntnQQFmxM3P+i6IdvM89uHxjFi1tY3o0UJxw4tN3ysQ5uwXC
         HPOYHZiJTdUtq2mUPZTfTWwGoc3usEGMnKmEhi25myifY17flqtXyvoHd6XYgoOSlG
         Wtg3R7KStC0pQ==
Date:   Mon, 28 Mar 2022 11:51:05 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 2/2] acpi/pci_root: negotiate CXL _OSC
Message-ID: <20220328185105.bbdxr4xyq6hnjeqy@offworld>
References: <20220326002430.797244-1-vishal.l.verma@intel.com>
 <20220326002430.797244-3-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220326002430.797244-3-vishal.l.verma@intel.com>
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

>+static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root, u32 support,
>+				      u32 *control, u32 cxl_support,
>+				      u32 *cxl_control)
> {
>	acpi_status status;
>-	u32 result, capbuf[OSC_CXL_CAPABILITY_DWORDS];
>+	u32 pci_result, cxl_result, capbuf[OSC_CXL_CAPABILITY_DWORDS];

While the wasted stack is hardly an issue, I do find it annoying that capbuf will be
bigger than necessary when is_cxl() == F, cap's pointer.length being capped at 12 bytes.
Doing capbuf dynamically and allocating memory would obviously not be worth it. Bleh :/

Thanks,
Davidlohr
