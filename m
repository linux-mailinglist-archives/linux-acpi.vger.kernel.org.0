Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D20CDE1490
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2019 10:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390298AbfJWIpl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 23 Oct 2019 04:45:41 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:31457 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390250AbfJWIpk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Oct 2019 04:45:40 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-173-UtFTQs3SPJ-8JSk6ctjl9Q-1; Wed, 23 Oct 2019 09:45:37 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 23 Oct 2019 09:45:36 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 23 Oct 2019 09:45:36 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Yin Fengwei' <fengwei.yin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>
Subject: RE: [PATCH v3] ACPI/processor_idle: Remove dummy wait if kernel is in
 guest mode
Thread-Topic: [PATCH v3] ACPI/processor_idle: Remove dummy wait if kernel is
 in guest mode
Thread-Index: AQHViXZzrjg4+aYFMUePkP2//whb1adn5/Eg
Date:   Wed, 23 Oct 2019 08:45:36 +0000
Message-ID: <30ee0a348f624698801691f65eeecd87@AcuMS.aculab.com>
References: <20191023074945.17016-1-fengwei.yin@intel.com>
In-Reply-To: <20191023074945.17016-1-fengwei.yin@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: UtFTQs3SPJ-8JSk6ctjl9Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Yin Fengwei
> Sent: 23 October 2019 08:50


> In function acpi_idle_do_entry(), an ioport access is used for dummy
> wait to guarantee hardware behavior. But it could trigger unnecessary
> vmexit if kernel is running as guest in virtualization environtment.
> 
> If it's in virtualization environment, the deeper C state enter
> operation (inb()) will trap to hyervisor. It's not needed to do
> dummy wait after the inb() call. So we remove the dummy io port
> access to avoid unnecessary VMexit.
> 
> We keep dummy io port access to maintain timing for native environment.
> 
> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> ---
> ChangeLog:
> v2 -> v3:
>  - Remove dummy io port access totally for virtualization env.
> 
> v1 -> v2:
>  - Use ndelay instead of dead loop for dummy delay.
> 
>  drivers/acpi/processor_idle.c | 36 ++++++++++++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index ed56c6d20b08..0c4a97dd6917 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -58,6 +58,17 @@ struct cpuidle_driver acpi_idle_driver = {
>  static
>  DEFINE_PER_CPU(struct acpi_processor_cx * [CPUIDLE_STATE_MAX], acpi_cstate);
> 
> +static void (*dummy_wait)(u64 address);
> +
> +static void default_dummy_wait(u64 address)
> +{
> +	inl(address);
> +}
> +
> +static void default_noop_wait(u64 address)
> +{
> +}
> +

Overengineered...
Just add:

static void wait_for_freeze(void)
{
#ifdef	CONFIG_X86
	/* No delay is needed if we are a guest */
	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
		return;
#endif
	/* Dummy wait op - must do something useless after P_LVL2 read
	   because chipsets cannot guarantee that STPCLK# signal
	   gets asserted in time to freeze execution properly. */
	inl(acpi_gbl_FADT.xpm_timer_block.address);
}

and use it to replace the inl().

...
> +#ifdef	CONFIG_X86
> +	/* For x86, if we are running in guest, we don't need extra
> +	 * access ioport as dummy wait.
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
> +		pr_err("We are in virtual env");
> +		dummy_wait = default_noop_wait;
> +	} else {
> +		pr_err("We are not in virtual env");
> +	}
> +#endif

WTF are the pr_err() for???

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

