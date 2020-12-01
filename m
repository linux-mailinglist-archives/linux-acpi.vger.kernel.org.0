Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4342E2CA90A
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Dec 2020 17:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390732AbgLAQ4A (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Dec 2020 11:56:00 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.2]:41095 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389102AbgLAQ4A (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Dec 2020 11:56:00 -0500
Received: from [100.112.130.149] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.us-west-2.aws.symcld.net id 86/89-16145-38476CF5; Tue, 01 Dec 2020 16:51:15 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRWlGSWpSXmKPExsWS8eIhr25zybF
  4g8dNAhb7r0tYdC00sFh4/xSrxddvt9kt3hyfzmSxfF8/o0VTZxObxeeOySwWq/e8YLZY+2Ue
  m8WZ05dYHbg9Js2cweyxc9Zddo9f29aweGxeoeUx72SgR0/bJiaP9/uusnlsudrO4vF5k1wAZ
  xRrZl5SfkUCa8bvxveMBUedK879esrYwPjIrIuRi0NI4D+jxKodK5i6GDmBnOeMEk2tbiC2sE
  CqxO9dc5lBbBEBdYmpHT1sIA3MAh1MEvsu9DNBdO9klFhxdRZYFZuAtsSWLb+Aqjg4eAVsJe7
  sFwAJswioSJzdfhBsgahAuMT6JSsZQWxeAUGJkzOfsIDYnAJ2EpcOb2AFsZkFLCRmzj/PCGGL
  S9x6Mp8JwpaX2P52DtgqCQEFics7pjJB2AkSy17eYZ7AKDgLydhZSEbNQjJqFpJRCxhZVjGaJ
  xVlpmeU5CZm5ugaGhjoGhoa6RoaWeqaGuglVukm6pUW65anFpfoGukllhfrFVfmJuek6OWllm
  xiBEZmSkGj0Q7Gv68/6B1ilORgUhLlXRJxLF6ILyk/pTIjsTgjvqg0J7X4EKMMB4eSBC97EVB
  OsCg1PbUiLTMHmCRg0hIcPEoivKtB0rzFBYm5xZnpEKlTjLocJ1ctWcQsxJKXn5cqJc6rXgxU
  JABSlFGaBzcClrAuMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLmPQqyiiczrwRu0yugI5iAj
  nD5fBjkiJJEhJRUA5PW3scf8qY/PTVLaZr5/jC2xaIrYuTYLn7t+N0zUzxldgmzsRTD8sZZ5k
  J2MTtm7tNfoTC9XcusfPvThPq5K+ruJnw4xtc78c9fztqpVQL72p1fr/0abLVhbcyC45qRxz5
  8atE1zvrO517upzlhE58Dx+feEG6pWb/25ceGyirzWWd7rCnd3e0m77ilO/N17+EFX+zvXHnp
  rPxE3zRw7vkdZSWue3semy3dcO3GjboP3yYdFNjbd7pNca3GjRevq00VLAu/VRy5O//Xw5kLE
  hqMJ0/prK2xVJl6m+dy/xzHIPctNw3LU38d8DN5m1i2W5PbvzFeklF8Qjb/etGPP8V+/90516
  tLodx61ZagC3lKLMUZiYZazEXFiQCGeYAy0wMAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-2.tower-326.messagelabs.com!1606841473!1191!1
X-Originating-IP: [104.232.225.13]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31602 invoked from network); 1 Dec 2020 16:51:14 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.13)
  by server-2.tower-326.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Dec 2020 16:51:14 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 808072C1BF16F734CEFA;
        Tue,  1 Dec 2020 11:51:13 -0500 (EST)
Received: from localhost.localdomain (10.38.96.254) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Tue, 1 Dec 2020
 08:51:12 -0800
Subject: Re: [External] Re: [PATCH v4 3/3] platform/x86: thinkpad_acpi: Add
 platform profile support
To:     Hans de Goede <hdegoede@redhat.com>
CC:     <mgross@linux.intel.com>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <rjw@rjwysocki.net>,
        <hadess@hadess.net>, <pobrn@protonmail.com>,
        <mario.limonciello@dell.com>, <eliadevito@gmail.com>,
        <bberg@redhat.com>, <dvhart@infradead.org>
References: <markpearson@lenovo.com>
 <20201126165143.32776-1-markpearson@lenovo.com>
 <20201126165143.32776-3-markpearson@lenovo.com>
 <e8dee4f7-3559-71a3-51d4-0b93b004715a@redhat.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <a02480ac-4f37-1d22-700b-e1b3565bb57f@lenovo.com>
Date:   Tue, 1 Dec 2020 11:51:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <e8dee4f7-3559-71a3-51d4-0b93b004715a@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.38.96.254]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans,

Sorry for the slow reply on this one - I went and did some 
investigation/testing first (and the US came back from Thanksgiving with 
a vengence of meetings....)

On 28/11/2020 09:55, Hans de Goede wrote:
> Hi,
> 
> On 11/26/20 5:51 PM, Mark Pearson wrote:
<snip>
>>
>>    drivers/platform/x86/thinkpad_acpi.c | 306 ++++++++++++++++++++++++++-
>>   1 file changed, 305 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
>> index 6a4c54db38fb..8463170391f5 100644
>> --- a/drivers/platform/x86/thinkpad_acpi.c
>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>> @@ -72,6 +72,7 @@
>>   #include <linux/uaccess.h>
>>   #include <acpi/battery.h>
>>   #include <acpi/video.h>
>> +#include <linux/platform_profile.h>
> 
> Please group this together with the other linux/foo.h includes.
Ack.

Is it OK if I tidy up the list to be alphabetical as seems generally 
preferred, or would you rather I didn't mess with it apart from the one 
small adjustment?
> 
>>   
<snip>
>> +}
>> +
>> +static int dytc_perfmode_get(int *perfmode, int *funcmode)
>> +{
>> +	int output, err, cmd_err;
>> +
>> +	if (!dytc_profile_available)
>> +		return -ENODEV;
>> +
>> +	err = dytc_command(DYTC_CMD_GET, &output);
>> +	if (err)
>> +		return err;
>> +
>> +	*funcmode = (output >> DYTC_GET_FUNCTION_BIT) & 0xF;
>> +	if (*funcmode == DYTC_FUNCTION_CQL) {
>> +		int dummy;
>> +		/*
>> +		 * We can't get the mode when in CQL mode - so we disable CQL
>> +		 * mode retrieve the mode and then enable it again.
>> +		 * As disabling/enabling CQL triggers an event we set a flag to
>> +		 * ignore these events. This will be cleared by the event handler
>> +		 */
>> +		dytc_ignore_next_event = true;
>> +		err = dytc_command(DYTC_DISABLE_CQL, &dummy);
>> +		if (err)
>> +			return err;
>> +
>> +		cmd_err = dytc_command(DYTC_CMD_GET, &output);
>> +		/* Check return condition after we've restored CQL state */
>> +
>> +		/* Again ignore this event */
>> +		dytc_ignore_next_event = true;
> 
> Are we sure the event-handler will have run before we do this second
> setting of the ignore_next_event bool? Maybe make it an atomic integer
> and increment / decrement the variable ?
> 
> E.g.:
> 
> Declaration:
> 
> static atomic_t dytc_ignore_next_event = ATOMIC_INIT();
> 
> Ignore next event:
> 		atomic_inc(&dytc_ignore_next_event);
> 		
> Check if event should be ignored:
> 
> 		if (!atomic_add_unless(&dytc_ignore_next_event, -1, 0))
> 			dytc_profile_refresh();
> 
> Note atomic_add_unless may needs some explanation, it adds -1 unless
> the atomic_t already contains 0. And it returns true if the addition
> was done. so if it returns true then dytc_ignore_next_event was not 0
> (it might be zero afterwards).
> 
> IOW if atomic_add_unless returns true then dytc_ignore_next_event was true,
> so then we should NOT continue with the refresh.
> 
In my testing the event handler always ran first, but the atomic 
approach is much nicer - thank you for the suggestion.
I've played a bit with this and tried a few things over the last few 
days and it has been working nicely
One thing I noticed is I think I need to add a mutex to protect so that 
a FN key press won't interfere with a user space access and vice-versa.

> 
> 
> 
>> +		err = dytc_command(DYTC_ENABLE_CQL, &dummy);
>> +		if (err)
>> +			return err;
>> +		if (cmd_err)
>> +			return cmd_err;
>> +	}
>> +	*perfmode = (output >> DYTC_GET_MODE_BIT) & 0xF;
>> +	return 0;
>> +}
>> +
>> +/*
>> + * dytc_profile_get: Function to register with platform_profile
>> + * handler. Returns current platform profile.
>> + */
>> +int dytc_profile_get(enum platform_profile_option *profile)
>> +{
>> +	int funcmode, perfmode;
>> +	int err;
>> +
>> +	err = dytc_perfmode_get(&perfmode, &funcmode);
>> +	if (err)
>> +		return err;
> 
> Can't we used a cached value here ? I presume we get an
> event when this is changed by the hotkey ? Esp. with the
> whole enable/disable CQL dance getting the value seems a
> bit expensive, so using a cached value might be better?

Agreed - I'll implement.
> 
>> +
>> +	/* Convert Lenovo DYTC profile to platform_profile */
>> +	err = convert_dytc_to_profile(perfmode, profile);
>> +	if (err)
>> +		return err;
>> +
>> +	dytc_current_profile = *profile;
>> +	return 0;
>> +}
>> +
>> +/*
>> + * dytc_profile_set: Function to register with platform_profile
>> + * handler. Sets current platform profile.
>> + */
>> +int dytc_profile_set(enum platform_profile_option profile)
>> +{
>> +	int cur_perfmode, cur_funcmode;
>> +	int output;
>> +	int err;
>> +
>> +	if (!dytc_profile_available)
>> +		return -ENODEV;
>> +
>> +	if (profile == platform_profile_balance) {
>> +		/* To get back to balance mode we just issue a reset command */
>> +		err = dytc_command(DYTC_CMD_RESET, &output);
>> +		if (err)
>> +			return err;
>> +	} else {
>> +		int perfmode;
>> +		int cmd_err;
>> +
>> +		err = convert_profile_to_dytc(profile, &perfmode);
>> +		if (err)
>> +			return err;
>> +
>> +		/* Determine if we are in CQL mode. This alters the commands we do */
>> +		err = dytc_perfmode_get(&cur_perfmode, &cur_funcmode);
>> +		if (err)
>> +			return err;
>> +
>> +		if (cur_funcmode == DYTC_FUNCTION_CQL) {
>> +			/* To set the mode we need to disable CQL first*/
>> +			dytc_ignore_next_event = true; /* Ignore event */
>> +			err = dytc_command(DYTC_DISABLE_CQL, &output);
>> +			if (err)
>> +				return err;
>> +		}
> 
> This seems somewhat duplicated from the get() code-path. Also you already doing
> a DYTC_DISABLE_CQL and DYTC_ENABLE_CQL in dytc_perfmode_get, which is not necessary
> to just get the funcmode which is all you need here AFAICT.
> 
> IOW it seems that when CQL is active you are now doing:
> 
> 1. dytc_perfmode_get() calls DYTC_CMD_GET
> 2. dytc_perfmode_get() calls DYTC_DISABLE_CQL
> 3. dytc_perfmode_get() calls DYTC_CMD_GET again, result is ignored (not used by dytc_profile_set)
> 4. dytc_perfmode_get() calls DYTC_ENABLE_CQL
> 5. dytc_profile_set() calls DYTC_DISABLE_CQL
> 6. dytc_profile_set() calls DYTC_SET_COMMAND
> 7. dytc_profile_set() calls DYTC_ENABLE_CQL
> 
> And you can really skip step 2-4 here.
> 
> I think it would be good to add a bunch of helpers:
> 
> 1. dytc_get_modes() -> DYTC_CMD_GET wrapper gets both modes, sets perfmode
> to -1 when funcmode is CQL
> 2. dytc_disable_cql_if_necessary() which takes funcmode as argument and is
> a no-op when funcmode != CQL
> 3. dytc_re_enable_cql_if_necessary() idem.
> 
> And then the flow in dytc_perfmode_get could look something like this
> (pseudo code minus error handling):
> 
> 	dytc_get_modes(&funcmode, &perfmode)
> 	if (funcmode != CQL) /* or alternatively check for perfmode != -1 */
> 		return success;
> 
> 	dytc_disable_cql_if_necessary(funcmode);
> 	dytc_get_modes(NULL, &perfmode);
> 	dytc_disable_cql_if_necessary(funcmode);
> 
> And in the non-balanced path of dytc_profile_set:
> 
> 	dytc_get_modes(&funcmode, NULL)
> 
> 	dytc_disable_cql_if_necessary(funcmode);
> 	dytc_set_mode(...);
> 	dytc_disable_cql_if_necessary(funcmode);
> 
> Note the NULL could be a dummy, but I find NULL a bit cleaner
> (at the cost of having to check for it in dytc_get_modes).
> 
> This is is just from a quick peek, when you implement this
> it might turn out to be less then ideal, IOW this is just
> a suggestion, feel free to deviate.

Agreed - and thank you for the suggestions. I did prototype a similar 
method and it has worked out nicely. I've got a bit more cleanup but the 
code is better than it was.
> 
> ###
> 
> Since this will require a bit of work, timing wise (wrt the 5.11 merge-window)
> it might be best to just keep this patch as is for v5, and only change
> patch 1 and 2 of the set, so that those will hopefully be ready for
> merging in time for the 5.11 window. I plan to pick this one up
> once 5.11-rc1 is out (and has the necessary ACPI bits) so we have some
> more time to get this one in shape.
> 
> For patch 1/2 the most important thing is to have a consumer of the
> new internal APIs (almost) ready and this code fulfills that in
> its current form.
OK - I think that makes sense. Just curious though - will you then just 
accept the platform_profile pieces (1 & 2)? Would it make it easier if I 
just push the updated first two patches and drop thinkpad_acpi.c for now 
(it will follow shortly, but is going to be a couple more days) or would 
you rather have everything and just pick the bits you want?

I've got the v5 ready (I think) for the platform profile and am still 
working on thinkpad_acpi.c with the improvements from above. I think 
I'll be a couple more days there.

Thank you!
Mark
