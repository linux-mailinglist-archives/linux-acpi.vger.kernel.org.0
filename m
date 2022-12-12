Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14BA64A7BD
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Dec 2022 19:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiLLS5P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Dec 2022 13:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiLLS4u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Dec 2022 13:56:50 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F02017887
        for <linux-acpi@vger.kernel.org>; Mon, 12 Dec 2022 10:55:05 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id a16so9782987qtw.10
        for <linux-acpi@vger.kernel.org>; Mon, 12 Dec 2022 10:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sad/hrzFQ5ykbrLpJr7Z8NgF9Sic8iJyl9PZUlU3hdI=;
        b=HjPs699wgKkANUQrrhYdOTrHOAL4jYLpg7OJ1yz695y7KhpcMvaOPPVdEpp6ZEyW1Y
         IRoxQ+ksxppdnTdYZGlvCrLZ141S9pSJCNtydJFsjeimRv6sh/FwhY43EAdfPr7rnn16
         29oBLcf0jY3RtzO3p+L3Onn37XV7HJ0S1Mf5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sad/hrzFQ5ykbrLpJr7Z8NgF9Sic8iJyl9PZUlU3hdI=;
        b=5knYJ8PEmUR9K3Jq1kx6enT4HYu4oy/KTsCOcAYtv0CnI2Mf7lQQdgvNjzjNwh6Fgg
         CqSPaQYeYEaQQ3Cz69f2lHvROOkU3EZnl3iF+Epn7phrx1cMSf+th8m6Pv1gKaGSUbGE
         iUZ0rTbVhNdH7+LtBLd7Cdz8j3o79BzDINGGLU6obP5IzKbY8O3YsXLsx6xtE6IvQwdB
         cm5loBDmxuP+Om4z9xItwriXDIJdOSGDy4xclKTHSc6Tx9TwhIR2IJmg1oIPkw+r0vQh
         7kwROSP4FW2kImRIZW4cn7BlfD1y/q1hz+Lp7Fpy4qb2ncG1e807+9AroG7hk1WAba3o
         R4GQ==
X-Gm-Message-State: ANoB5pl4KwR7jJ8NTmwduynxOb1xvw6fvxt7hSaoks4tQrAMXkazI6oF
        9BroxkB9NrZRG8Oqw8gQ1T2p/Q==
X-Google-Smtp-Source: AA0mqf5u3yvJyeQ73wKo0JZCXelSPXCh7UDX321VC/+pogVrXrwdOU1ppocOhYM701mRKvSRVhBBmw==
X-Received: by 2002:a05:622a:4017:b0:3a5:a2f7:36aa with SMTP id cf23-20020a05622a401700b003a5a2f736aamr24563314qtb.44.1670871304540;
        Mon, 12 Dec 2022 10:55:04 -0800 (PST)
Received: from meerkat.local ([142.113.79.147])
        by smtp.gmail.com with ESMTPSA id f16-20020ac859d0000000b00397e97baa96sm6445727qtf.0.2022.12.12.10.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:55:04 -0800 (PST)
Date:   Mon, 12 Dec 2022 13:54:59 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v4 0/9] CXL: Process event logs
Message-ID: <20221212185459.x5wn42exhhycckun@meerkat.local>
References: <20221211-test-b4-v4-0-9f45dfeec102@intel.com>
 <Y5a88UgaE3EzJFQh@iweiny-mobl>
 <20221212161613.mz42m7n6eswjwdjv@meerkat.local>
 <Y5d3ArpuLYl4g4Mc@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5d3ArpuLYl4g4Mc@iweiny-desk3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Dec 12, 2022 at 10:46:26AM -0800, Ira Weiny wrote:
> > It fills out the To: and Cc: headers but doesn't actually send
> > actual mail to those accounts. Mail servers don't actually pay any attention
> > to those headers -- all that matters is what destinations are given to the
> > server during the envelope negotiation.
> 
> I did not know that.  But I was kind of coming to that conclusion based on
> what I saw happen.
> 
> > 
> > I do realize that this is confusing. :/
> 
> Only to those mere mortals such as myself who don't know squat about mail
> protocols!  :-D

It's completely normal not to know how that works -- and you shouldn't either.

> > Should I include anything in the output about this?
> 
> Maybe.  I'm not trying to put more burden on you.  But for the ignorant maybe
> it is a good idea.  I did panic when I saw all the to/cc addresses filled in.

I added a large notice about that to the --reflect output:

	[...]
	---
	Ready to:
	  - send the above messages to just konstantin@linuxfoundation.org (REFLECT MODE)
	  - via web endpoint: https://lkml.kernel.org/_b4_submit

	REFLECT MODE:
		The To: and Cc: headers will be fully populated, but the only
		address given to the mail server for actual delivery will be
		konstantin@linuxfoundation.org

		Addresses in To: and Cc: headers will NOT receive this series.

	Press Enter to proceed or Ctrl-C to abort

Hopefully, it will be less worrisome to others in the future.

Thank you for trying out b4 prep/send!

-K
