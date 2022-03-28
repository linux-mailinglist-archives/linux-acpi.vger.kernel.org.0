Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFB24E9EEC
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Mar 2022 20:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbiC1SZf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Mar 2022 14:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240336AbiC1SZe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Mar 2022 14:25:34 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40309137;
        Mon, 28 Mar 2022 11:23:51 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8D0C16A0115;
        Mon, 28 Mar 2022 18:23:50 +0000 (UTC)
Received: from pdx1-sub0-mail-a309.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B9FA36A1576;
        Mon, 28 Mar 2022 18:23:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1648491830; a=rsa-sha256;
        cv=none;
        b=ihq2J4rpq7+0/n3y3L+hyGNmsoVB8M6QK+kQqCtkwbwu/MlpfYyA1Z4lUgLD0ughTyv0gI
        6bvqgAF1y0GSSNw561DKrgDiOLEJOsX/7VefkHOM8l9GBPM/dh+34TqenwYyi3lvvHLxNx
        E4GRgvZo7Ky38C82FFrqmf9hl38cwg6UBJOGQvMLSMY+UhIWpkzFHQtRxJC/SNfSp7hJ91
        70S7oRKmil42vIeCJAGp+2kQl6gr7csh3XgE6EbDNpHfD5IJ/Lb0A//dCZktWuTzBfMucZ
        185qSjhLUrpRb4oJotEhZfnwCKsbO3ZTDeeNNPEwmwHoLY91rlJz+byLi4A6iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1648491830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Cu4op8j0ood3P3SLtPlvbjD/HyhV4ESSAHjpdTttD30=;
        b=oGlloEuptKp8cteF5Bm9D9hJVcp8qxsqH1vkvmTIUAnQtYwEDd0hpphIFr5L9q8sz0rGwM
        gZfseAaqnzZDG1pHPbYmIMJpYoyL6OlICQvbMYqXprweIr5C7VjrwIxYvAVxlCYO8g7xRA
        z4P0oEmlGGbPaIrl33gDTlLqBWQt6ZTghBnjQa0+XqDBhTkx5/cjhSLNKl4dRQOMLhKu9d
        SZRJeWvDFxWFAVuJdSByeXvVQ/Q6asrHyAnv/UPO3vm/Axd7qdF3KBW46YizYJKqBtuntd
        9tgr2NBqDcJ2kIELWpnUygjVT82TxNW2qBNFKrpQS+bwIKV1xja1SPBeioHByQ==
ARC-Authentication-Results: i=1;
        rspamd-5d5c987fbc-8fsp8;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a309.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.106.158.142 (trex/6.5.3);
        Mon, 28 Mar 2022 18:23:50 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Imminent-Tart: 46157f9f11c288ce_1648491830404_857859877
X-MC-Loop-Signature: 1648491830404:402425823
X-MC-Ingress-Time: 1648491830404
Received: from offworld (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a309.dreamhost.com (Postfix) with ESMTPSA id 4KS1Kt5HPVz1dr;
        Mon, 28 Mar 2022 11:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1648491827;
        bh=TMP5kEijuEL941y+wuN16R0Ea5pxp+EcY2pBOO/Cu90=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=fQ+8zRgPgQMFYg+JiM1dIUEotpAb2IuImNZ4IyidLBVlHSe5gXdTySqHTbejPhMh1
         SowXotYSRys8xe71It5wYhZHQWDUgpYfXgnssziMW46I/GD3/JzEOF8weluvkxN+Lz
         MJNhaF/Qz3EjN4Mu4o+3yg94rpMMfZnpIb70fw4zyfZb95kXobmwaHVEm92xTxAxLn
         Eo2pwmPvUZCXguhPrzW7jMKJPtYqwjdC871l3+qQz2k667ugwxH/IkooYY7gMh1L5J
         LPDd5Xwd9/pK1m9RckmK5Gc/cjrdYEhmg9cu0N6h9s8AYl6h5bLX0TAU53Y+Lv7/EA
         Vn5wqymzWPnAQ==
Date:   Mon, 28 Mar 2022 11:23:43 -0700
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
Message-ID: <20220328182343.4tg746vcizx6fhrk@offworld>
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

Hi Vishal,

A few small comments below, but overall I like this series.

On Fri, 25 Mar 2022, Vishal Verma wrote:

>+static u32 acpi_osc_ctx_get_pci_control(struct acpi_osc_context *context)
>+{
>+	u32 *ret = context->ret.pointer;
>+
>+	return ret[OSC_CONTROL_DWORD];
>+}

Should this one go into a more generic acpi.h? For example, another user
could be acpi_bus_osc_negotiate_usb_control().

>+
>+static u32 acpi_osc_ctx_get_cxl_control(struct acpi_osc_context *context)
>+{
>+	u32 *ret = context->ret.pointer;
>+
>+	return ret[OSC_CXL_CONTROL_DWORD];
>+}

... and perhaps this one too? But just for symmetry with the pci one, as there
are no users out side of pci_root.c. Both helpers want to be inline too. Btw
this probably also goes for the is_pci/cxl() helpers.

Thanks,
Davidlohr
