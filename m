Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECD94D4739
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 13:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242119AbiCJMvX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 07:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241082AbiCJMvW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 07:51:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AEB9149942
        for <linux-acpi@vger.kernel.org>; Thu, 10 Mar 2022 04:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646916620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kqIk+qFtJgUBK+8XBGsXeTRPvB12yfmtwQuUTSJuwRg=;
        b=TcJats5T+Iy7OsNYtQGUZlmZDYM1ij8HUjQGZNIQMvn+xX9ZA6OR1BC8e4VITT+kt7TeIZ
        lu2nb5C9VPuwGoSRYDe7JvxKCZtFnxuiXWmeDRyRoD7vLuUWnEFHSv8yBJohgMjMUC/RZ3
        XDmekAD1DQZWaYG7LqFK1VYpJx+EKqU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-gMW4AATjOnCuz9rKUx9FLg-1; Thu, 10 Mar 2022 07:50:19 -0500
X-MC-Unique: gMW4AATjOnCuz9rKUx9FLg-1
Received: by mail-ej1-f71.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so3024978ejw.9
        for <linux-acpi@vger.kernel.org>; Thu, 10 Mar 2022 04:50:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kqIk+qFtJgUBK+8XBGsXeTRPvB12yfmtwQuUTSJuwRg=;
        b=dHgGNfU/9msXVSa8kHx41ew4MwDbhLRJs0WbnfvPlFdq/2uUFocxC1Ru5gJu6Gf8bs
         JcPtuVKdR4SNE/wSKj0/f/3oS8saqT97o00fTtcDmQlRETRNFRdD2FMwWUctB3itg/ur
         HjmI4AAzvq4o/RDJCv3DAQ+sOL1J1KfnroWv4HDQJVfRkSQSr+DZxF/ot10MU15FGUmc
         ONCKXbOk8+pQ1pB6uy1xZZAMvQ0/qyWOqGzZlleciYG9Jfgv7huQWQKG06flrMQZ7IaR
         1wfUMRpavM08atcEqy4rpVVau99H+bWvVi5ee+Cr6var44U1FU9wDmMjooRTjQ+Khulz
         axRA==
X-Gm-Message-State: AOAM530TQIS8bgjZp8BCDkhSLyvDCgyBoRT/x7hlR1b9yI0mBZOPm+1r
        dHULCLKIKHaQYwB7sBxx89KETyzmFjN0v98Fc7B65je07IVKsuhu666lVRLlXezn0cEch8gDfSB
        YD6Zi/tfwR43EyRNwYFmZGg==
X-Received: by 2002:a05:6402:40c4:b0:416:3e66:1825 with SMTP id z4-20020a05640240c400b004163e661825mr4209851edb.284.1646916618011;
        Thu, 10 Mar 2022 04:50:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzz52vVQsnTxToJPUcYpkmT0ZzW/sva8Nr4SPkqiA160bWsihC6fpDeNerHC2QepuCNYLPQoQ==
X-Received: by 2002:a05:6402:40c4:b0:416:3e66:1825 with SMTP id z4-20020a05640240c400b004163e661825mr4209831edb.284.1646916617798;
        Thu, 10 Mar 2022 04:50:17 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id u5-20020a170906b10500b006ce6fa4f510sm1745355ejy.165.2022.03.10.04.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 04:50:17 -0800 (PST)
Message-ID: <c74ee0be-0f48-3528-a7cb-4644834ba4da@redhat.com>
Date:   Thu, 10 Mar 2022 13:50:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Please revert commit 4287509b4d21e34dc492 from 5.16.y
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>
References: <CAJZ5v0gE52NT=4kN4MkhV3Gx=M5CeMGVHOF0jgTXDb5WwAMs_Q@mail.gmail.com>
 <YinyzxnSsty8BDKn@kroah.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YinyzxnSsty8BDKn@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 3/10/22 13:45, Greg Kroah-Hartman wrote:
> On Thu, Mar 10, 2022 at 01:26:16PM +0100, Rafael J. Wysocki wrote:
>> Hi Greg & Sasha,
>>
>> Commit 4287509b4d21e34dc492 that went into 5.16.y as a backport of
>> mainline commit dc0075ba7f38 ("ACPI: PM: s2idle: Cancel wakeup before
>> dispatching EC GPE") is causing trouble in 5.16.y, but 5.17-rc7
>> including the original commit is fine.
>>
>> This is most likely due to some other changes that commit dc0075ba7f38
>> turns out to depend on which have not been backported, but because it
>> is not an essential fix (and it was backported, because it carried a
>> Fixes tag and not because it was marked for backporting), IMV it is
>> better to revert it from 5.16.y than to try to pull all of the
>> dependencies in (and risk missing any of them), so please do that.
>>
>> Please see this thread:
>>
>> https://lore.kernel.org/linux-pm/31b9d1cd-6a67-218b-4ada-12f72e6f00dc@redhat.com/
> 
> Odd that this is only showing up in 5.16 as this commit also is in 5.4
> and 5.10 and 5.15. 

This has sofar mostly(only?) been reported by Fedora and Arch users which
both have 5.16.y kernels in their update repos ATM.

Regards,

Hans


