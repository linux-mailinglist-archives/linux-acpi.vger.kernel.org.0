Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37DABE1CAB
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2019 15:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390236AbfJWNde (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Oct 2019 09:33:34 -0400
Received: from mail-eopbgr70045.outbound.protection.outlook.com ([40.107.7.45]:43073
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731301AbfJWNde (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Oct 2019 09:33:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kb1qC8pALtJwaN6jLVRJ2hDu6KyO41iQL40bEdQ/Py9vxuGhgreReIL9gV5Josle9TJ7GVIBt15AFPKUnYLoIqJw8tdNCpilcfhGxuooJ4IE0vJxuZwbOYiQbENq4iSBbFAtZqYNfBVv5q5TdmHW9J3jEbZ9u2jRI7Ngq2JW86HfIlsl/jK4qV/zX0KjvDvGYp7+9WzvaqbmmTnGJUvfXoIgbHjbovXN32YhUYtXACvxaxdKEWhk2ovxwXdIig28875uCK5B21W24NTOvpz9Tg4zhLPiYEvQaT8J0c4By7cCVfQQg0UBV0TtmjjvkNtHx7au7260c1blfTEmNYFtfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPrOn08Q9nqkb2XRKJw3p6sPSVg/pbAibeAqiJAwdvg=;
 b=KO/B8tb+6W+FEy0Atp3j7prK1thOHgbaWHZGV+2p/4rRhICI+eobDkS62yaTueFpfDHGM/xhY+/nPnNhFngt3DfV6mBxDshaaWpX7TL3/Z5RhoQKPnxM3RQZMkcNIl8A4R2ITeM/jazfJz9I7+xeuWfvSeaF92uGCKOkhVjCtw3+LBMNzZceNI9NKt0nBnSZs3h8dX1gKqlR5CetEu2TvLEKDxs8CWUG6msZWsSKhwlprkpL9k4SFSPimw+uaauXG/VOKcMZOq/jTY3LvnTXUUMOaH08NXl49xPRbft/udUqpVGWZTW/SF2C6wkrdQ844uxwJ2baVn4C/U0G+r51lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPrOn08Q9nqkb2XRKJw3p6sPSVg/pbAibeAqiJAwdvg=;
 b=nQX+leAZe485kubj0RhMEsbkDIbeHiLGV9F/Vx6ragbBSnayAwtjBHAGzWguae+ySluDEEKXOufk8ip5kS1/xmdZGNLsh1g50lin18GHltaTP6CJL9RIjqVDH7pZFGC8kNrlyuvisrhLmGon5COxu9f1BS4YCisXk2QavB31SYw=
Received: from AM7PR04MB7015.eurprd04.prod.outlook.com (52.135.57.19) by
 AM7PR04MB6952.eurprd04.prod.outlook.com (10.141.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Wed, 23 Oct 2019 13:33:28 +0000
Received: from AM7PR04MB7015.eurprd04.prod.outlook.com
 ([fe80::3924:7adb:47f2:2ece]) by AM7PR04MB7015.eurprd04.prod.outlook.com
 ([fe80::3924:7adb:47f2:2ece%7]) with mapi id 15.20.2367.022; Wed, 23 Oct 2019
 13:33:28 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
Thread-Topic: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
Thread-Index: AQHViSTjqsMfVqNAR0a2lS+zHVHmpw==
Date:   Wed, 23 Oct 2019 13:33:28 +0000
Message-ID: <AM7PR04MB7015D5B0C6952BF6B04C140CEE6B0@AM7PR04MB7015.eurprd04.prod.outlook.com>
References: <VI1PR04MB7023DF47D046AEADB4E051EBEE680@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAJZ5v0g-hTOhVJOz28CGmpcxUiiTrYyV=ARwNCN9w4doeRcCRw@mail.gmail.com>
 <VI1PR04MB7023808153A1FD2740FACF01EE6B0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAJZ5v0gWdFVbvPobLic7F+bRrz-QUoV3GPhpawdFT0MVjAhuOQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c857a464-b123-49d0-3dd3-08d757bd96db
x-ms-traffictypediagnostic: AM7PR04MB6952:|AM7PR04MB6952:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB6952AA5C02DD7EB3D9E46794EE6B0@AM7PR04MB6952.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(199004)(189003)(7696005)(14444005)(6506007)(76176011)(186003)(256004)(86362001)(53546011)(102836004)(81156014)(14454004)(316002)(476003)(446003)(486006)(44832011)(26005)(8676002)(71190400001)(71200400001)(52536014)(8936002)(25786009)(81166006)(229853002)(110136005)(54906003)(478600001)(66066001)(305945005)(6436002)(76116006)(66476007)(66556008)(91956017)(9686003)(66446008)(7736002)(66946007)(4326008)(74316002)(64756008)(2906002)(3846002)(6116002)(5660300002)(99286004)(6246003)(4001150100001)(7416002)(55016002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR04MB6952;H:AM7PR04MB7015.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RL/diReDnVF+Qyr/RI0i5kay1G7CHmi9rPbcgwexPe3FUoZ1gIZpzDIvMKCwEfFZn0q/6rgTR+z53baAtJOaJYSTgF+KG9kkoAmdgplpiJFmBNaQ//LFOu7YomzGwBB9lqsf2b/WeaH3+uCo0LV0rF65Ne0kL4O2wGeME9N2zgcOMpejMNgSCfgIx/piXIxa6NVMMu2HV9n0TTl+PKZmFWUlJ4mdcHiCagfcUvFQxfGksk1WMRhoxV7sPs98eQL2lbVrwd+EdMtGlOnICbvKjiTGiO58FeZsiyrxnRicLQl62DItcSiNW/vIVgVTVGig/kEz4DLXCpLH78Tu5FA7s8WVCyOqgYmiluLGvSMLAHnFf0Vwq06Eb0tm5FgvOsOa7Px+SpNhwyTClzzrz20IkgxZtKWU5ANe4bpLSZII8c13q91DTRD5WJHVcKL7OWzx
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c857a464-b123-49d0-3dd3-08d757bd96db
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 13:33:28.6435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9XYIq6noqx6mVNliHuLR4tO8iKiEv16+qWCflFf+A+KYe1lWoVDBis6U5gM815PAKah2X2eeXMargaSt0E6HyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6952
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2019-10-23 11:54 AM, Rafael J. Wysocki wrote:=0A=
> On Wed, Oct 23, 2019 at 4:20 AM Leonard Crestez <leonard.crestez@nxp.com>=
 wrote:=0A=
>> On 2019-10-23 1:48 AM, Rafael J. Wysocki wrote:=0A=
>>> On Wed, Oct 23, 2019 at 12:06 AM Leonard Crestez=0A=
>>> <leonard.crestez@nxp.com> wrote:=0A=
>>>> I've been working on a series which add DEV_PM_QOS support to devfreq,=
=0A=
>>>> now at v9:=0A=
>>>>=0A=
>>>> Your third patch removes DEV_PM_QOS_FREQUENCY_MIN/MAX that my series=
=0A=
>>>> depends upon. I found the email on patchwork, hopefully the in-reply-t=
o=0A=
>>>> header is OK?=0A=
>>>>=0A=
>>>> As far as I can tell the replacement ("frequency qos") needs constrain=
ts=0A=
>>>> to be managed outside the device infrastructure and it's not obviously=
=0A=
>>>> usable a generic mechanism for making "min_freq/max_freq" requests to =
a=0A=
>>>> specific device.=0A=
>>>=0A=
>>> You can add a struct freq_constrants pointer to struct dev_pm_info and=
=0A=
>>> use it just fine.  It doesn't have to be bolted into struct=0A=
>>> dev_pm_qos.=0A=
>>=0A=
>> I'm not sure what you mean by this? min/max_freq was already available=
=0A=
>> in dev_pm_qos so it's not clear why it would be moved somewhere else.=0A=
>> What I'm looking for is a mechanism to make min/max_freq requests on a=
=0A=
>> per-device basis and DEV_PM_QOS_MIN_FREQUENCY already did that.=0A=
>>=0A=
>> Reuse is good, right?=0A=
> =0A=
> But they go away in patch 3 of this series as there are no users in=0A=
> the tree.  Sorry about that. >=0A=
>>>> I've read a bit through your emails and it seems the problem is that=
=0A=
>>>> you're dealing with dev_pm_qos on per-policy basis but each "struct=0A=
>>>> cpufreq_policy" can cover multiple CPU devices.=0A=
>>>>=0A=
>>>> An alternative solution which follows dev_pm_qos would be to add=0A=
>>>> notifiers for each CPU inside cpufreq_online and cpufreq_offline. This=
=0A=
>>>> makes quite a bit of sense because each CPU is a separate "device" wit=
h=0A=
>>>> a possibly distinct list of qos requests.=0A=
>>>=0A=
>>> But combining the lists of requests for all the CPUs in a policy=0A=
>>> defeats the idea of automatic aggregation of requests which really is=
=0A=
>>> what PM QoS is about.=0A=
>>=0A=
>> My primary interest is the "dev" part of dev_pm_qos: making pm_qos=0A=
>> requests tied to a specific device.=0A=
> =0A=
> The list of requests needs to be associated with the user of the=0A=
> effective constraint.  If that is the device, it is all good.=0A=
The phrase "user of the effective constraint" is somewhat unclear.=0A=
=0A=
I'm using the target device as dev for dev_pm_qos, not the requestor. =0A=
This is consistent with how it was used for cpufreq: thermal called a =0A=
dev_pm_qos_add_request on with dev =3D cpu_dev not a thermal sensor or =0A=
anything else.=0A=
=0A=
However looking at other dev_pm_qos users there are instances of a =0A=
driver calling dev_pm_qos_add_request on it's own device but this is not =
=0A=
a strict requirement, correct?=0A=
=0A=
>>> There have to be two lists of requests per policy, one for the max and=
=0A=
>>> one for the min frequency >=0A=
>>>> If cpufreq needs a group of CPUs to run at the same frequency then it=
=0A=
>>>> should deal with this by doing dev_pm_qos_read_frequency on each CPU=
=0A=
>>>> device and picking a frequency that attempts to satisfy all constraint=
s.=0A=
>>>=0A=
>>> No, that would be combining the requests by hand.=0A=
>>=0A=
>> It's just a loop though.=0A=
> =0A=
> Yes, it is, and needs to be run on every change of an effective=0A=
> constraint for any CPU even if the total effective constraint doesn't=0A=
> change.  And, of course, the per-policy user space limits would need=0A=
> to be combined with that by hand.=0A=
> =0A=
> Not particularly straightforward if you asked me.=0A=
=0A=
Well, this cpu-to-policy aggregation could also use a pm_qos_constraint =0A=
object instead of looping.=0A=
=0A=
> Not to mention the fact that, say, cpu_cooling, has a per-policy list=0A=
> of requests anyway.=0A=
> =0A=
>>>> Handling sysfs min/max_freq through dev_pm_qos would be of dubious=0A=
>>>> value, though I guess you could register identical requests for each C=
PU.=0A=
>>>>=0A=
>>>> I'm not familiar with what you're trying to accomplish with PM_QOS oth=
er=0A=
>>>> than replace the sysfs min_freq/max_freq files:=0A=
>>>=0A=
>>> QoS-based management of the frequency limits is not really needed for=
=0A=
>>> that.  The real motivation for adding it were things like thermal and=
=0A=
>>> platform firmware induced limits that all have their own values to=0A=
>>> combine with the ones provided by user space.=0A=
>>=0A=
>> Current users seem to be thermal-related. Do you care about min/max_freq=
=0A=
>> requests from stuff not directly tied to a CPU?=0A=
> =0A=
> Yes, I do.=0A=
> =0A=
> And they will need to add requests per policy.=0A=
> =0A=
>>>> What I want to do is add=0A=
>>>> a driver using the interconnect driver which translates requests for=
=0A=
>>>> "bandwidth-on-a-path" into "frequency-on-a-device". More specifically =
a=0A=
>>>> display driver could request bandwidth to RAM and this would be=0A=
>>>> translated into min frequency for NoC and the DDR controller, both of=
=0A=
>>>> which implement scaling via devfreq:=0A=
>>>>=0A=
>>>> This is part of an effort to upstream an out-of-tree "busfreq" feature=
=0A=
>>>> which allows device device to make "min frequency requests" through an=
=0A=
>>>> entirely out-of-tree mechanism. It would also allow finer-grained=0A=
>>>> scaling that what IMX tree currently support.=0A=
>>>>=0A=
>>>> If you're making cpufreq qos constrains be "per-cpufreq-policy" then=
=0A=
>>>> it's not clear how you would handle in-kernel constraints from other=
=0A=
>>>> subsystems. Would users have to get a pointer to struct cpufreq_policy=
=0A=
>>>> and struct freq_constraints?=0A=
>>>=0A=
>>> Yes.=0A=
>>>=0A=
>>>> That would make object lifetime a nightmare!=0A=
>>>=0A=
>>> Why really?  It is not much different from the device PM QoS case=0A=
>>   >> Actually,  is a simple=0A=
>>> one-for-one replacement of the former.  As it turns out, all of its=0A=
>>> users have access to a policy object anyway already.=0A=
>>=0A=
>> All current users are very closely tied to cpufreq, what I had in mind=
=0A=
>> is requests from unrelated subsystems.=0A=
> =0A=
> You can use cpufreq policy notifiers for that.  Add a request for each=0A=
> CPU in the policy (or for each related CPU if that is needed) to=0A=
> policy->constraints on CREATE_POLICY and remove them on REMOVE_POLICY.=0A=
> That's all you need to do.=0A=
> =0A=
> BTW, the original code from Viresh did that already, I haven't changed=0A=
> it.  And it didn't have per-CPU lists of frequency requests for that=0A=
> matter, it used the ones in policy->cpu as the per-policy lists, which=0A=
> doesn't work.=0A=
> =0A=
>> Browsing through the cpufreq core it seems that it's possible for a=0A=
>> struct cpufreq_policy to be created and destroyed at various points, the=
=0A=
>> simplest example being rmmod/modprobe on a cpufreq driver.=0A=
>>=0A=
>> The freq_qos_add_request function grabs a pointer to struct=0A=
>> freq_constraints, this can become invalid when cpufreq_policy is freed.=
=0A=
>>=0A=
>> I guess all users need to register a CPUFREQ_POLICY_NOTIFIER and make=0A=
>> sure to freq_qos_add_request every time?=0A=
> =0A=
> Yes.=0A=
> =0A=
> The policy is the user of the effective constraint anyway and holding=0A=
> on to a list of requests without a user of the effective constraint=0A=
> would be, well, not useful.=0A=
> =0A=
>> Looking at your [PATCH 2/3] I  can't spot any obvious issue, thermal cla=
mping=0A=
>> code seems to get the appropriate callbacks.=0A=
>>=0A=
>>>> But dev_pm_qos solves this by tying to struct device.=0A=
>>=0A=
>> The lifetime of "struct device" is already controlled by=0A=
>> get_device/put_device.=0A=
> =0A=
> And why does this matter here?=0A=
=0A=
My point is that dev_pm_qos is easier for consumers to use than dealing =0A=
with cpufreq_policy lifetime and has less exposure to cpufreq =0A=
implementation details.=0A=
=0A=
But all current consumers seem to be appropriately coupled into cpufreq.=0A=
=0A=
>>> Well, the cpufreq sysfs is per-policy and not per-CPU and we really=0A=
>>> need a per-policy min and max frequency in cpufreq, for governors etc.=
=0A=
>>=0A=
>> Aggregation could be performed at two levels:=0A=
>>=0A=
>> 1) Per cpu device (by dev_pm_qos)=0A=
>> 2) Per policy (inside cpufreq)=0A=
>>=0A=
>> The per-cpu dev_pm_qos notifier would just update a per-policy=0A=
>> pm_qos_constraints object. The second step could even be done strictly=
=0A=
>> inside the cpufreq core using existing pm_qos, no need to invent new=0A=
>> frameworks.=0A=
>>=0A=
>> Maybe dev_pm_qos is not a very good fit for cpufreq because of these=0A=
>> "cpu device versus cpufreq_policy" issues but it makes a ton of sense=0A=
>> for devfreq. Can you maybe hold PATCH 3 from this series pending further=
=0A=
>> discussion?=0A=
> =0A=
> It can be reverted at any time if need be and in 5.4 that would be dead c=
ode.=0A=
=0A=
I guess I can post v10 of my "devfreq pm qos" which starts by reverting =0A=
"PATCH 3" of this series?=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
