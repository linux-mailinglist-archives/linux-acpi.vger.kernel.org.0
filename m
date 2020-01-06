Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8E08131B86
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Jan 2020 23:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgAFWfE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Jan 2020 17:35:04 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33015 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAFWfE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Jan 2020 17:35:04 -0500
Received: by mail-pl1-f194.google.com with SMTP id c13so22385542pls.0;
        Mon, 06 Jan 2020 14:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qpvMgFdftf9ANhib2LlVwDtagmLWmW++B/ixHTrUb0U=;
        b=oYdr2Rsm8aY2Krd2gOUV/nJh56dClC+QsvrjkZF3g/7GGV1ZjYbCgC4lXZmvSnSlER
         9p8dv+MtdtyLh1S0gm08MwXvYox2H4s9MLGLjyyRGOx8ACReA7dDOoD70Ub7rtPbKpzw
         0cAv/QLyio0m6BvC515cMhuUV6XxH9XbggQF5Ll+faWzs5iYch9Gld46pXdiAyq3Cqkt
         UKeuOqgjJgrzVPHJaheY8VjrbTtjg9lE5f0s1q8DejgvfisEHxXbNz9+oz/7hW9D+8bP
         ypElH5K9LVab+l4oupj+e56UP1wap/IBCMfJzpFL6qeSHgMyZA2WRPI8YlgxkycTh8e+
         BdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qpvMgFdftf9ANhib2LlVwDtagmLWmW++B/ixHTrUb0U=;
        b=Zfd6WIBbeooPZgV7b12zRG0gQL2/40yRqD7sHB8+2NsjfDlO54pygNo6Pf4X+GhSSa
         AqL+dNkJKB9iJzU+4A2Kbb1XTxg8y+Uiyvy2aoE7/LHsrxEoXkqp3RHRUSwGz8TJ9ucM
         Uu5szpYA+e+epS+TqBwt8JJedttSdcIR7Duwf6S4WUfk0Yzv/jxlnTwTtlUg4MucYsjo
         5vucbGc/jEtW0aei8pS+2pmqaI7VJXy8/EZJd3BEDoEtNYCheMpMuTQsby5W56VOvkes
         1TbkJBe4cEMfV5/kAraDyOBA3kBH5mDSQ1NsZtcjZCn4LMc7nCXnRhcKuX3Ve2T4mnTY
         krbA==
X-Gm-Message-State: APjAAAVHItpGJyEEYeP/l/A4zC6JA7Np1auBq9bZgDxREA6m9BV3JAko
        BizVvd7e9QAhL3ggLpwOGoo=
X-Google-Smtp-Source: APXvYqwB0AkExqosTf+he1/2pNPXNah/DcoAIBnpMa/3YyMC3mf9MP5n3ID6YAxLrVLdEIrwmyRbnQ==
X-Received: by 2002:a17:902:8a8d:: with SMTP id p13mr102320928plo.296.1578350103830;
        Mon, 06 Jan 2020 14:35:03 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w131sm81300933pfc.16.2020.01.06.14.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 14:35:03 -0800 (PST)
Date:   Mon, 6 Jan 2020 14:35:00 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Qian Cai <cai@lca.pw>
Cc:     rafael.j.wysocki@intel.com, gregkh@linuxfoundation.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drivers/base/test: fix global-out-of-bounds error
Message-ID: <20200106223500.GG8314@dtor-ws>
References: <20200106163735.1826-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106163735.1826-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 06, 2020 at 11:37:35AM -0500, Qian Cai wrote:
> The commit c032ace71c29 ("software node: add basic tests for property
> entries") introduced a global-out-of-bounds error because it forgot to
> add a terminator of "nodes "for software_node_register_nodes() to
> process.
> 
>  	# Subtest: property-entry
>  	1..7
>  	ok 1 - pe_test_uints
>  	ok 2 - pe_test_uint_arrays
>  	ok 3 - pe_test_strings
>  	ok 4 - pe_test_bool
>  	ok 5 - pe_test_move_inline_u8
>  	ok 6 - pe_test_move_inline_str
>  ==================================================================
>  BUG: KASAN: global-out-of-bounds in
>  software_node_register_nodes+0x41/0x80
>  Read of size 8 at addr ffffffff989ef250 by task kunit_try_catch/316
> 
>  CPU: 17 PID: 316 Comm: kunit_try_catch Not tainted
>  5.5.0-rc4-next-20200106+ #1
>  Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40
>  03/09/2018
>  Call Trace:
>   dump_stack+0xa0/0xea
>   print_address_description.constprop.5.cold.7+0x64/0x384
>   __kasan_report.cold.8+0x7a/0xc0
>   kasan_report+0x12/0x20
>   __asan_load8+0x71/0xa0
>   software_node_register_nodes+0x41/0x80
>   pe_test_reference+0x1eb/0x1200
>   kunit_try_run_case+0x6b/0xd1
>   kunit_generic_run_threadfn_adapter+0x29/0x50
>   kthread+0x1e6/0x210
>   ret_from_fork+0x27/0x50
> 
>  The buggy address belongs to the variable:
>   nodes.21544+0x30/0x920
> 
>  Memory state around the buggy address:
>   ffffffff989ef100: fa fa fa fa 00 04 fa fa fa fa fa fa 00 00 00 00
>   ffffffff989ef180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  >ffffffff989ef200: fa fa fa fa 00 00 00 00 00 00 fa fa fa fa fa fa
>                                                   ^
>   ffffffff989ef280: 00 06 fa fa fa fa fa fa 00 00 04 fa fa fa fa fa
>   ffffffff989ef300: 00 00 fa fa fa fa fa fa 00 05 fa fa fa fa fa fa
>  ==================================================================
>  Disabling lock debugging due to kernel taint
>  	ok 7 - pe_test_reference
>  ok 8 - property-entry
> 
> Fixes: c032ace71c29 ("software node: add basic tests for property entries")
> Signed-off-by: Qian Cai <cai@lca.pw>

Thanks Qian.

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/base/test/property-entry-test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/base/test/property-entry-test.c b/drivers/base/test/property-entry-test.c
> index da812834b631..abe03315180f 100644
> --- a/drivers/base/test/property-entry-test.c
> +++ b/drivers/base/test/property-entry-test.c
> @@ -366,6 +366,7 @@ static void pe_test_reference(struct kunit *test)
>  	static const struct software_node nodes[] = {
>  		{ .name = "1", },
>  		{ .name = "2", },
> +		{ }
>  	};
>  
>  	static const struct software_node_ref_args refs[] = {
> -- 
> 2.21.0 (Apple Git-122.2)
> 

-- 
Dmitry
