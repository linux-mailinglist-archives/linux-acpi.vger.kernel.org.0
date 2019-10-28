Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69105E7A81
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2019 21:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfJ1UvZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Oct 2019 16:51:25 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54387 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJ1UvZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Oct 2019 16:51:25 -0400
Received: from cust-east-parth2-46-193-72-114.wb.wifirst.net (46.193.72.114) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id ae23aec7c4df68ae; Mon, 28 Oct 2019 21:51:22 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] acpi: fix potential race conditions bypassing checks
Date:   Mon, 28 Oct 2019 21:51:22 +0100
Message-ID: <3605712.hsAW26GfSv@kreacher>
In-Reply-To: <20191028183114.15709-1-kjlu@umn.edu>
References: <20191028183114.15709-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Monday, October 28, 2019 7:31:14 PM CET Kangjie Lu wrote:
> "obj" is a local variable. Elements are deep-copied from external
> package to obj and security-checked. The original code is
> seemingly fine; however, compilers optimize the deep copies into
> shallow copies, introducing potential race conditions. For
> example, the checks for type and length may be bypassed.

How exactly?

What compiler(s) do such optimizations in this particular case?

> The fix tells compilers to not optimize the deep copy by inserting
> "volatile".

Have you actually analyzed the object code produced by the compiler with and
without the volatile to determine whether or not it has an effect as expected
on code generation?

> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/acpi/processor_throttling.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
> index 532a1ae3595a..6f4d86f8a9ce 100644
> --- a/drivers/acpi/processor_throttling.c
> +++ b/drivers/acpi/processor_throttling.c
> @@ -413,7 +413,7 @@ static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
>  	acpi_status status = 0;
>  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>  	union acpi_object *ptc = NULL;
> -	union acpi_object obj = { 0 };
> +	volatile union acpi_object obj = { 0 };
>  	struct acpi_processor_throttling *throttling;
>  
>  	status = acpi_evaluate_object(pr->handle, "_PTC", NULL, &buffer);
> 




