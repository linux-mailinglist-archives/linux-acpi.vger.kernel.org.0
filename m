Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7E84E46CB
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Mar 2022 20:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiCVTij (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Mar 2022 15:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiCVTii (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Mar 2022 15:38:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7888A6C8;
        Tue, 22 Mar 2022 12:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=GNyzORUx4GXTT7/hj1mCmOnIXmKv2J5yosWB9fpbDWg=; b=MdScEsmNUv8CYjaq6xyKA/QxN9
        99HtzcD8C5Luv02SuH8KKYzNXG2/z9eoPR6F+Of7b2lajNndvnQgTFYcmirKYEOKIl7Se9JldmMm5
        E/263AwsHbY1LjLCfck+kKyE6/+BtsVrjFp+MPte5dcSxYvDzYluqVmur6voqTxcLZcU/xVskTKBX
        Rnv8nuDMz3n95ftN044wXbdf+9PPcPf2/ifZZPTxINFS9hvFes7ZlPcS7C7k6pCnwJElIJDlz3crP
        egdH6e1Il32660Qsnf7ExebqC9Kk7y4mHrwW7K5cop+zlkCe1y9/jFjb5XLJZ52VLs82F0v5GP/LB
        LQ5sxRaA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWkJR-003Y0z-FU; Tue, 22 Mar 2022 19:37:01 +0000
Message-ID: <adfeb8bb-50b3-7ff3-a55f-19fc23cd1121@infradead.org>
Date:   Tue, 22 Mar 2022 12:36:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Docs: admin/kernel-parameters: edit a few boot options
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-ia64@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20220321012216.23724-1-rdunlap@infradead.org>
 <CAJZ5v0jBFOWZZrGuBb0GyJa3rKRwSYXrMFOtGu8jLnQ+OPtXHw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAJZ5v0jBFOWZZrGuBb0GyJa3rKRwSYXrMFOtGu8jLnQ+OPtXHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 3/22/22 10:41, Rafael J. Wysocki wrote:
> On Mon, Mar 21, 2022 at 2:22 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>> Clean up some of admin-guide/kernel-parameters.txt:
>>
>> a. "smt" should be "smt=" (S390)
>> b. add "smt-enabled" for POWERPC
>> c. Sparc supports the vdso= boot option
>> d. make the tp_printk options (2) formatting similar to other options
>>    by adding spacing
>> e. add "trace_clock=" with a reference to Documentation/trace/ftrace.rst
>> f. use [IA-64] as documented instead of [ia64]
>> g. fix formatting and text for test_suspend=
> This ->
> 
>> h. fix formatting for swapaccount=
>> i. fix formatting and grammar for video.brightness_switch_enabled=
> -> and the last one are fine with me, but I suppose that there will be a v2?

Yes, there will be a v2.

thanks.

-- 
~Randy
